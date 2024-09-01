from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from .forms import UserRegistrationForm
from .models import Product, UserInteraction, Favorite

def redirect_to_register(request):
    """Redirect root URL to the register page."""
    return redirect('register')

def register(request):
    """User registration view."""
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)  # Log in the user after registration
            return redirect('home')  # Redirect to home page after registration
    else:
        form = UserRegistrationForm()
    return render(request, 'register.html', {'form': form})

@login_required
def home(request):
    """Home view showing product list."""
    products = Product.objects.all()
    user_favorites = Product.objects.filter(favorite__user=request.user)  # Get favorite products
    return render(request, 'home.html', {'products': products, 'user_favorites': user_favorites})

@login_required
def record_interaction(request, product_id):
    """Log user interaction with a product."""
    product = get_object_or_404(Product, id=product_id)
    UserInteraction.objects.create(user=request.user, product=product)
    return redirect('home')

@login_required
def add_favorite(request, product_id):
    """Add or remove a product from favorites."""
    product = get_object_or_404(Product, id=product_id)
    favorite, created = Favorite.objects.get_or_create(user=request.user, product=product)
    if not created:
        favorite.delete()  # Remove from favorites if it already exists
    return redirect('home')

@login_required
def favorite_products(request):
    """Display favorite products."""
    favorites = Favorite.objects.filter(user=request.user)
    products = [favorite.product for favorite in favorites]
    return render(request, 'favorites.html', {'products': products})

def logout_view(request):
    """Logout view."""
    logout(request)
    return redirect('login')
