# backend/core/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('apps.api.urls')),  # L'API gère les vues publiques
    path('users/', include('apps.users.urls')),
    path('ai/', include('ai.urls')),
]
