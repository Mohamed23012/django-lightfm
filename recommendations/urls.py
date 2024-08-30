from django.urls import path
from . import views

urlpatterns = [
    path('', views.recommendations_view, name='recommendations'),
    path('login/', views.login_signup_view, name='login_signup'),
    path('products/', views.product_listing_view, name='product_listing'),
    # Other routes...
]
