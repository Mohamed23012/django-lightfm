from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from .forms import UserRegistrationForm
from .models import Product, UserInteraction

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
    favorites = UserInteraction.objects.filter(user=request.user, interaction_type='favorite')
    favorite_products = [interaction.product for interaction in favorites]
    return render(request, 'home.html', {'products': products, 'favorite_products': favorite_products})

@login_required
def record_interaction(request, product_id, interaction_type):
    """Log user interaction with a product."""
    product = get_object_or_404(Product, id=product_id)
    UserInteraction.objects.create(user=request.user, product=product, interaction_type=interaction_type)
    return redirect('home')

@login_required
def favorites(request):
    """View to show user's favorite products."""
    favorites = UserInteraction.objects.filter(user=request.user, interaction_type='favorite')
    favorite_products = [interaction.product for interaction in favorites]
    return render(request, 'favorites.html', {'products': favorite_products})

def logout_view(request):
    """Logout view."""
    logout(request)
    return redirect('login')
