from rest_framework import serializers
from .models import Predict
    
class PredictSerializer(serializers.ModelSerializer):
    class Meta:
        model = Predict
        fields = ['id', 'messages','origin_image','image', 'created_at', 'updated_at']
        
class PredictEditSerializer(serializers.ModelSerializer):
    class Meta:
        model = Predict
        fields = ['id', 'image', 'created_at', 'updated_at']