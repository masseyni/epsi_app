from rest_framework import serializers
from .models import News, Event, Course, ChatbotMessage
from django.contrib.auth.models import User
from django.utils.timezone import timezone

class NewsSerializer(serializers.ModelSerializer):
    class Meta:
        model = News
        fields = ['id', 'title', 'content', 'image', 'date_published', 'location']

    def validate_title(self, value):
        if len(value) < 5:
            raise serializers.ValidationError("Title must be at least 5 characters long")
        return value.strip()

    def validate_content(self, value):
        if len(value) < 20:
            raise serializers.ValidationError("Content must be at least 20 characters long")
        return value.strip()

class EventSerializer(serializers.ModelSerializer):
    formatted_date = serializers.SerializerMethodField()
    
    class Meta:
        model = Event
        fields = ['id', 'title', 'description', 'date', 'formatted_date', 'image', 'location']

    def get_formatted_date(self, obj):
        return obj.date.strftime("%Y-%m-%d %H:%M")

    def validate_date(self, value):
        if value < timezone.now():
            raise serializers.ValidationError("Event date cannot be in the past")
        return value

    def validate_description(self, value):
        if len(value) < 30:
            raise serializers.ValidationError("Description must be at least 30 characters long")
        return value.strip()

class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ['id', 'title', 'description', 'image']

    def validate_title(self, value):
        if len(value) < 3:
            raise serializers.ValidationError("Title must be at least 3 characters long")
        return value.strip()

class UserProfileSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()
    
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'full_name']
        read_only_fields = ['id', 'email']
        extra_kwargs = {
            'username': {'required': True, 'min_length': 3},
            'first_name': {'required': True},
            'last_name': {'required': True}
        }

    def get_full_name(self, obj):
        return f"{obj.first_name} {obj.last_name}".strip()

class ChatbotMessageSerializer(serializers.ModelSerializer):
    user_name = serializers.SerializerMethodField()
    
    class Meta:
        model = ChatbotMessage
        fields = ['id', 'user_message', 'bot_response', 'timestamp', 'user', 'user_name']
        read_only_fields = ['id', 'timestamp', 'user_name']

    def get_user_name(self, obj):
        return obj.user.get_full_name() or obj.user.username