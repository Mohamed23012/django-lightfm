import numpy as np
from lightfm import LightFM
from lightfm.data import Dataset
from .models import UserInteraction, Product
import logging

logger = logging.getLogger(__name__)

def fetch_interaction_data():
    """
    Fetch a small subset of user interactions from the database.
    """
    interactions = UserInteraction.objects.all()[:100]  # Limit to 100 interactions
    logger.info(f"Fetched {len(interactions)} interactions.")
    return interactions

def prepare_lightfm_data(interactions):
    """
    Prepare data for LightFM model by creating a dataset and an interaction matrix.
    """
    dataset = Dataset()
    dataset.fit((x.user_id for x in interactions), (x.product_id for x in interactions))

    # Build the interactions matrix from the interaction data
    interactions_matrix, _ = dataset.build_interactions(((x.user_id, x.product_id) for x in interactions))

    # Log the shape and size of the interactions matrix
    logger.info(f"Interactions matrix shape: {interactions_matrix.shape}")
    logger.info(f"Interactions matrix size: {interactions_matrix.data.nbytes / 1024 / 1024:.2f} MB")

    return dataset, interactions_matrix


def train_lightfm_model(interactions_matrix):
    """
    Train the LightFM model using the interaction matrix.
    """
    try:
        logger.info("Initializing LightFM model...")
        model = LightFM(loss='warp', no_components=10)  # Reduced components
        logger.info("Model initialized successfully.")

        logger.info("Fitting model...")
        model.fit(interactions_matrix, epochs=1, num_threads=1, verbose=True)  # Reduced epochs and threads
        logger.info("Model fitted successfully.")

        return model
    except Exception as e:
        logger.error(f"Error during LightFM model training: {e}")
        raise e


def recommend_products(user_id, model, dataset):
    """
    Generate product recommendations for a given user.
    """
    try:
        user_internal_id = dataset.mapping()[0][user_id]
        product_internal_ids = list(dataset.mapping()[2].values())

        # Predict scores for all products for this user
        scores = model.predict(user_internal_id, np.array(product_internal_ids))

        # Rank products by score in descending order and get top 5
        top_items = np.argsort(-scores)[:5]

        # Map internal LightFM IDs back to original product IDs
        product_mapping = {v: k for k, v in dataset.mapping()[2].items()}
        recommended_product_ids = [product_mapping[x] for x in top_items]

        return Product.objects.filter(id__in=recommended_product_ids)
    except KeyError:
        logger.warning(f"User {user_id} not found in the dataset. Unable to generate recommendations.")
        return []
    except Exception as e:
        logger.error(f"Error generating recommendations: {e}", exc_info=True)
        return []
