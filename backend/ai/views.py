from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import QARequestSerializer, QAResponseSerializer
from .models import QAResponse
from .services import QAService

# Create your views here.

class QAIAPIView(APIView):
    def post(self, request):
        serializer = QARequestSerializer(data=request.data)
        if serializer.is_valid():
            question = serializer.validated_data['question']
            category = serializer.validated_data.get('category', None)
            language = serializer.validated_data.get('language', 'fr')
            ai_service = QAService()
            answer = ai_service.get_answer(question, language=language)
            qa = QAResponse.objects.create(
                question=question,
                answer=answer,
                category=category,
                language=language
            )
            response_serializer = QAResponseSerializer(qa)
            return Response(response_serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
