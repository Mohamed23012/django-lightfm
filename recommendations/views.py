from itertools import count
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, logout
from django.core.cache import cache
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Count
from .models import Product, UserInteraction
from .forms import UserRegistrationForm
from .lightfm_recommender import fetch_interaction_data, prepare_lightfm_data, train_lightfm_model, recommend_products
import logging

logger = logging.getLogger(__name__)

def redirect_to_register(request):
    """Redirect root URL to the register page."""
    return redirect('register')

def register(request):
    """User registration view."""
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('home')
    else:
        form = UserRegistrationForm()
    return render(request, 'register.html', {'form': form})

@login_required
def home(request):
    """Home view showing product list and recommendations."""
    try:
        logger.info("Fetching products...")
        products_list = Product.objects.annotate(interaction_count=Count('userinteraction')).order_by('-interaction_count', 'id')
        logger.info("Products fetched successfully.")

        # Pagination
        page = request.GET.get('page', 1)
        paginator = Paginator(products_list, 20)  # Show 20 products per page
        try:
            products = paginator.page(page)
        except PageNotAnInteger:
            products = paginator.page(1)
        except EmptyPage:
            products = paginator.page(paginator.num_pages)

        # Commenting out LightFM-related code to isolate the problem
        # model = cache.get('lightfm_model')
        # dataset = cache.get('lightfm_dataset')

        # if model is None or dataset is None:
        #     logger.info("Model or dataset not in cache. Preparing data...")
        #     interactions = fetch_interaction_data()
        #     if len(interactions) < 5:  # Reduced threshold
        #         logger.warning("Not enough interactions to train the model.")
        #         recommended_products = []
        #     else:
        #         dataset, interactions_matrix = prepare_lightfm_data(interactions)
        #         model = train_lightfm_model(interactions_matrix)

        #         # Cache the model and dataset for future use
        #         cache.set('lightfm_model', model, 3600)  # Cache for 1 hour
        #         cache.set('lightfm_dataset', dataset, 3600)

        #         logger.info("Generating recommendations...")
        #         recommended_products = recommend_products(request.user.id, model, dataset)
        #         logger.info("Recommendations generated successfully.")
        # else:
        #     logger.info("Using cached model and dataset.")
        #     logger.info("Generating recommendations...")
        #     recommended_products = recommend_products(request.user.id, model, dataset)
        #     logger.info("Recommendations generated successfully.")

        recommended_products = []  # Fallback when LightFM is commented out

        favorites = UserInteraction.objects.filter(user=request.user, interaction_type='favorite')
        favorite_products = [interaction.product for interaction in favorites]

    except Exception as e:
        logger.error(f"An error occurred: {e}", exc_info=True)
        return render(request, 'home.html', {'error_message': str(e)})

    return render(request, 'home.html', {
        'products': products,
        'favorite_products': favorite_products,
        'recommended_products': recommended_products
    })

@login_required
def record_interaction(request, product_id, interaction_type):
    """Log user interaction with a product."""
    try:
        product = get_object_or_404(Product, id=product_id)
        UserInteraction.objects.create(user=request.user, product=product, interaction_type=interaction_type)
        logger.info(f"Recorded {interaction_type} interaction for user {request.user.id} with product {product_id}")
    except Exception as e:
        logger.error(f"Error recording interaction: {e}", exc_info=True)
    return redirect('home')

@login_required
def favorites(request):
    """View to show user's favorite products."""
    try:
        favorites = UserInteraction.objects.filter(user=request.user, interaction_type='favorite')
        favorite_products = [interaction.product for interaction in favorites]
        
        # Pagination for favorites
        page = request.GET.get('page', 1)
        paginator = Paginator(favorite_products, 20)  # Show 20 favorites per page
        try:
            favorites_page = paginator.page(page)
        except PageNotAnInteger:
            favorites_page = paginator.page(1)
        except EmptyPage:
            favorites_page = paginator.page(paginator.num_pages)
        
    except Exception as e:
        logger.error(f"Error fetching favorites: {e}", exc_info=True)
        return render(request, 'error.html', {'message': str(e)})
    
    return render(request, 'favorites.html', {'products': favorites_page})

def logout_view(request):
    """Logout view."""
    logout(request)
    return redirect('login')
