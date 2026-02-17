from django.urls import path
from .views import QAIAPIView

urlpatterns = [
    path('qa/', QAIAPIView.as_view(), name='qa-ai'),
] 