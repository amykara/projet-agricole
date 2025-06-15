from rest_framework import serializers
from .models import Culture

class CultureSerializer(serializers.ModelSerializer):
    class Meta:
        model = Culture
        fields = '__all__'
