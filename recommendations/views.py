import numpy as np
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .recommender import load_model
from .models import Product

@api_view(['GET'])
def get_recommendations(request, user_id):
    model, dataset = load_model()
    
    user_mapping = {user_id: idx for idx, user_id in enumerate(dataset.mapping()[0])}
    product_mapping = {product_id: idx for idx, product_id in enumerate(dataset.mapping()[2])}
    reverse_product_mapping = {idx: product_id for product_id, idx in product_mapping.items()}
    
    if user_id not in user_mapping:
        return Response({'error': 'Utilisateur non trouvé'}, status=404)
    
    user_index = user_mapping[user_id]
    
    scores = model.predict(user_index, np.arange(len(product_mapping)))
    top_indices = np.argsort(-scores)[:10]
    recommended_product_ids = [reverse_product_mapping[idx] for idx in top_indices]
    recommended_products = Product.objects.filter(id__in=recommended_product_ids)
    
    recommendations = [
        {
            'id': product.id,
            'name': product.name,
            'category': product.category,
        }
        for product in recommended_products
    ]
    
    return Response(recommendations)
from django.shortcuts import redirect, render

def recommendations_view(request):
    return render(request, 'recommendations/recommendation.html')
def login_signup_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('product_listing')  # Redirect to product listing page
    else:
        form = AuthenticationForm()

    return render(request, 'login_signup.html', {'form': form})

def product_listing_view(request):
    return render(request, 'recommendations/product_listing.html')