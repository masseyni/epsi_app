from rest_framework import serializers
from .models import QAResponse

class QAResponseSerializer(serializers.ModelSerializer):
    class Meta:
        model = QAResponse
        fields = ['id', 'question', 'answer', 'category', 'language', 'created_at']

class QARequestSerializer(serializers.Serializer):
    question = serializers.CharField()
    category = serializers.CharField(required=False, allow_blank=True)
    language = serializers.CharField(default='fr') 