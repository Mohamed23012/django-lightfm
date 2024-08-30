from django.shortcuts import render
import numpy as np
from lightfm import LightFM
from lightfm.data import Dataset
from .models import Interaction, User, Product
import pickle
import os
from django.conf import settings

# Chemin où le modèle sera sauvegardé
MODEL_PATH = os.path.join(settings.BASE_DIR, 'recommendations', 'lightfm_model.pkl')

def train_model():
    # Récupérer toutes les interactions
    interactions = Interaction.objects.all()

    # Extraire les identifiants uniques des utilisateurs et des produits
    user_ids = interactions.values_list('user_id', flat=True).distinct()
    product_ids = interactions.values_list('product_id', flat=True).distinct()

    # Initialiser le Dataset de LightFM
    dataset = Dataset()
    dataset.fit(users=user_ids, items=product_ids)

    # Préparer les tuples (user_id, product_id, interaction_value)
    interaction_tuples = interactions.values_list('user_id', 'product_id', 'interaction_value')

    # Construire la matrice d'interactions et la matrice de poids
    (interactions_matrix, weights_matrix) = dataset.build_interactions(
        ((user, product, value) for user, product, value in interaction_tuples)
    )

    # Initialiser le modèle LightFM avec la perte 'warp' (Weighted Approximate-Rank Pairwise)
    model = LightFM(loss='warp')

    # Entraîner le modèle
    model.fit(interactions_matrix, sample_weight=weights_matrix, epochs=30, num_threads=4)

    # Sauvegarder le modèle et le dataset pour une utilisation ultérieure
    with open(MODEL_PATH, 'wb') as f:
        pickle.dump({'model': model, 'dataset': dataset}, f)

    print(f"Modèle entraîné et sauvegardé à {MODEL_PATH}")

    return model
import pickle
import os
from django.conf import settings

# Chemin où le modèle est sauvegardé
MODEL_PATH = os.path.join(settings.BASE_DIR, 'recommendations', 'lightfm_model.pkl')

def load_model():
    with open(MODEL_PATH, 'rb') as f:
        data = pickle.load(f)
    return data['model'], data['dataset']

def recommendations_view(request):
    return render(request, 'recommendations/recommendations.html')