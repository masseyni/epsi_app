# backend/apps/users/urls.py
from django.urls import path
from .views import user_profile, register_user, login_user

urlpatterns = [
    path('profile/', user_profile, name='user_profile'),
    path('register/', register_user, name='register_user'),
    path('login/', login_user, name='login_user'),
]
