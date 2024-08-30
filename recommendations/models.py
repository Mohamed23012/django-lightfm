from django.db import models

# Create your models here.


class Product(models.Model):
    name = models.CharField(max_length=255)
    category = models.CharField(max_length=255)

class User(models.Model):
    username = models.CharField(max_length=255)

class Interaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    interaction_type = models.CharField(max_length=50)  # Ex: 'click', 'wishlist'
    interaction_value = models.IntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)
