from django.db import models

class Predict(models.Model):
    messages = models.TextField(blank=True, null=True)
    origin_image = models.ImageField(upload_to='static/predicts/', null=True, blank=True)
    image = models.ImageField(upload_to='static/predicts/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.message