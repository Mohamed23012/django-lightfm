from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib.auth.decorators import login_required
from .forms import UserRegistrationForm
from .models import Product, UserInteraction

def register(request):
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
    products = Product.objects.all()
    return render(request, 'home.html', {'products': products})

@login_required
def product_click(request, product_id):
    product = Product.objects.get(id=product_id)
    UserInteraction.objects.create(user=request.user, product=product)
    return redirect('home')