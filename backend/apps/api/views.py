# backend/apps/api/views.py
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view, permission_classes
from rest_framework import status
from .models import News, Event, Course, ChatbotMessage
from .serializers import NewsSerializer, EventSerializer, CourseSerializer, ChatbotMessageSerializer, UserProfileSerializer
from django.contrib.auth.models import User

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def protected_view(request):
    return Response({"message": "Accès autorisé uniquement aux utilisateurs authentifiés."})

@api_view(['GET'])
def home(request):
    return Response({"message": "Bienvenue sur l'API EPSI !"})

# Endpoints pour les actualités
@api_view(['GET'])
def news_list(request):
    news = News.objects.all()
    serializer = NewsSerializer(news, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def news_detail(request, pk):
    try:
        news = News.objects.get(pk=pk)
    except News.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    serializer = NewsSerializer(news)
    return Response(serializer.data)

# Endpoints pour les événements
@api_view(['GET'])
def event_list(request):
    events = Event.objects.all()
    serializer = EventSerializer(events, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def event_detail(request, pk):
    try:
        event = Event.objects.get(pk=pk)
    except Event.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    serializer = EventSerializer(event)
    return Response(serializer.data)

# Endpoints pour les cours
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def course_list(request):
    courses = Course.objects.all()
    serializer = CourseSerializer(courses, many=True)
    return Response(serializer.data)

# Endpoints pour le profil utilisateur
@api_view(['GET', 'PUT'])
@permission_classes([IsAuthenticated])
def user_profile(request):
    user = request.user
    
    if request.method == 'GET':
        serializer = UserProfileSerializer(user)
        return Response(serializer.data)
    
    elif request.method == 'PUT':
        serializer = UserProfileSerializer(user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Endpoint pour le chatbot (préparation pour l'intégration future)
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def chatbot_message(request):
    user_message = request.data.get('message', '')
    
    # Ici, vous pourriez intégrer un service de chatbot réel
    # Pour l'instant, nous renvoyons une réponse statique
    bot_response = "Je suis le chatbot de l'EPSI. Cette fonctionnalité sera bientôt disponible. Comment puis-je vous aider?"
    
    # Enregistrer la conversation
    chat_message = ChatbotMessage.objects.create(
        user_message=user_message,
        bot_response=bot_response,
        user=request.user
    )
    
    serializer = ChatbotMessageSerializer(chat_message)
    return Response(serializer.data)
