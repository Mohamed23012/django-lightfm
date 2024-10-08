from django.urls import path
from django.contrib.auth import views as auth_views
from . import views

urlpatterns = [
    path('', views.redirect_to_register, name='redirect_to_register'),
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name='login.html'), name='login'),
    path('home/', views.home, name='home'),
    path('logout/', views.logout_view, name='logout'),
    path('product/<int:product_id>/interaction/<str:interaction_type>/', views.record_interaction, name='record_interaction'),
    path('favorites/', views.favorites, name='favorites'),
    

]
