from django.contrib import admin
from .models import Predict

# Register your models here.
@admin.register(Predict)
class PredictAdmin(admin.ModelAdmin):
    list_display = ['id', 'messages','image', 'created_at', 'updated_at']