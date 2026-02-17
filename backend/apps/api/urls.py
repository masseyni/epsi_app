from django.urls import path
from .views import (
    home, protected_view, news_list, news_detail, 
    event_list, event_detail, course_list, 
    user_profile, chatbot_message
)

urlpatterns = [
    path('', home, name='home'),
    path('protected/', protected_view, name='protected'),
    
    # Endpoints pour les actualités
    path('news/', news_list, name='news-list'),
    path('news/<int:pk>/', news_detail, name='news-detail'),
    
    # Endpoints pour les événements
    path('events/', event_list, name='event-list'),
    path('events/<int:pk>/', event_detail, name='event-detail'),
    
    # Endpoints pour les cours
    path('courses/', course_list, name='course-list'),
    
    # Endpoints pour le profil utilisateur
    path('users/profile/', user_profile, name='user-profile'),
    
    # Endpoint pour le chatbot
    path('chatbot/message/', chatbot_message, name='chatbot-message'),
]
