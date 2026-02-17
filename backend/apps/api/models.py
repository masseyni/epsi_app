from django.db import models
from django.utils import timezone

class News(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    image = models.ImageField(upload_to='news_images/', null=True, blank=True)
    date_published = models.DateTimeField(default=timezone.now)
    location = models.CharField(max_length=100, blank=True)
    
    class Meta:
        verbose_name_plural = "News"
        ordering = ['-date_published']
    
    def __str__(self):
        return self.title

class Event(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    date = models.DateField()
    image = models.ImageField(upload_to='event_images/', null=True, blank=True)
    location = models.CharField(max_length=100, blank=True)
    
    class Meta:
        ordering = ['date']
    
    def __str__(self):
        return self.title

class Course(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    image = models.ImageField(upload_to='course_images/', null=True, blank=True)
    
    def __str__(self):
        return self.title

class ChatbotMessage(models.Model):
    user_message = models.TextField()
    bot_response = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey('auth.User', on_delete=models.CASCADE, null=True, blank=True)
    
    class Meta:
        ordering = ['-timestamp']
    
    def __str__(self):
        return f"Message: {self.user_message[:30]}..."