from django.core.cache import cache
from .models import News, Event

class NewsService:
    @staticmethod
    def get_latest_news(limit=10):
        cache_key = f'latest_news_{limit}'
        news = cache.get(cache_key)
        
        if news is None:
            news = News.objects.order_by('-created_at')[:limit]
            cache.set(cache_key, news, timeout=300)  # Cache for 5 minutes
            
        return news

class EventService:
    @staticmethod
    def get_upcoming_events():
        cache_key = 'upcoming_events'
        events = cache.get(cache_key)
        
        if events is None:
            events = Event.objects.filter(date__gte=timezone.now())
            cache.set(cache_key, events, timeout=600)  # Cache for 10 minutes
            
        return events