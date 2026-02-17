from django.db import models

# Create your models here.

class QAResponse(models.Model):
    question = models.TextField()
    answer = models.TextField()
    category = models.CharField(max_length=50, blank=True, null=True)
    language = models.CharField(max_length=10, default='fr')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Q: {self.question[:30]}..."
