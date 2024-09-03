import numpy as np
from lightfm import LightFM
from lightfm.data import Dataset

# Sample data for testing
users = [1, 2]
items = [101, 102]
interactions = [(1, 101), (2, 102)]

dataset = Dataset()
dataset.fit(users, items)
interactions_matrix, _ = dataset.build_interactions(interactions)

# Initialize LightFM model
model = LightFM(loss='warp')

# Train with verbose mode
model.fit(interactions_matrix, epochs=10, num_threads=1, verbose=True)

print("LightFM test completed successfully.")
