from difflib import SequenceMatcher
from .models import QAResponse
import json
from typing import Dict, List, Optional, Tuple
from django.conf import settings
from django.core.cache import cache
from django.core.cache.backends.base import DEFAULT_TIMEOUT
from django.http import HttpRequest
from functools import wraps
import time
from datetime import datetime, timedelta

def rate_limit(requests_per_minute: int = 60):
    def decorator(view_func):
        request_history = {}
        
        @wraps(view_func)
        def wrapped_view(request: HttpRequest, *args, **kwargs):
            client_ip = request.META.get('REMOTE_ADDR')
            current_time = time.time()
            
            # Nettoyer l'historique des requêtes plus anciennes qu'une minute
            request_history[client_ip] = [
                req_time for req_time in request_history.get(client_ip, [])
                if current_time - req_time < 60
            ]
            
            # Vérifier si le client a dépassé la limite
            if len(request_history.get(client_ip, [])) >= requests_per_minute:
                return {
                    'error': 'Trop de requêtes. Veuillez attendre une minute.',
                    'status': 'error'
                }
            
            # Ajouter la requête actuelle à l'historique
            if client_ip not in request_history:
                request_history[client_ip] = []
            request_history[client_ip].append(current_time)
            
            return view_func(request, *args, **kwargs)
        return wrapped_view
    return decorator

class QAService:
    def __init__(self):
        self.knowledge_base = self._load_knowledge_base()
        self.cache_timeout = getattr(settings, 'CACHE_TIMEOUT', DEFAULT_TIMEOUT)

    def _load_knowledge_base(self) -> Dict:
        try:
            with open('backend/ai/knowledge_base.json', 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}

    def _get_cache_key(self, question: str) -> str:
        return f'qa_cache_{question.lower().strip()}'

    @rate_limit(requests_per_minute=60)
    def get_answer(self, question: str, language: str = 'fr') -> Dict:
        # Vérifier le cache
        cache_key = self._get_cache_key(question)
        cached_response = cache.get(cache_key)
        if cached_response:
            return {
                'answer': cached_response,
                'status': 'success',
                'source': 'cache'
            }

        # Trouver la meilleure correspondance
        best_match = self._find_best_match(question)
        if not best_match:
            return {
                'answer': "Je ne peux pas répondre à cette question pour le moment.",
                'status': 'error',
                'source': 'no_match'
            }

        # Mettre en cache la réponse
        cache.set(cache_key, best_match['answer'], self.cache_timeout)

        return {
            'answer': best_match['answer'],
            'status': 'success',
            'source': 'knowledge_base',
            'category': best_match['category']
        }

    def _find_best_match(self, question: str) -> Optional[Dict]:
        question = question.lower().strip()
        best_score = 0.2  # Seuil de similarité réduit
        best_match = None

        # Comparer avec les questions complètes
        for category, entries in self.knowledge_base.items():
            for entry in entries:
                q = entry['question'].lower()
                score = self._calculate_similarity(question, q)
                if score > best_score:
                    best_score = score
                    best_match = {
                        'answer': entry['answer'],
                        'category': category
                    }

        # Comparer avec les mots-clés
        if not best_match:
            question_words = set(question.split())
            for category, entries in self.knowledge_base.items():
                for entry in entries:
                    keywords = set(entry.get('keywords', []))
                    if keywords:
                        score = len(question_words.intersection(keywords)) / len(keywords)
                        if score > best_score:
                            best_score = score
                            best_match = {
                                'answer': entry['answer'],
                                'category': category
                            }

        return best_match

    def _calculate_similarity(self, str1: str, str2: str) -> float:
        # Implémentation simple de la similarité de Jaccard
        set1 = set(str1.split())
        set2 = set(str2.split())
        intersection = len(set1.intersection(set2))
        union = len(set1.union(set2))
        return intersection / union if union > 0 else 0

    def add_question(self, question: str, answer: str, category: str, keywords: List[str] = None) -> bool:
        try:
            if category not in self.knowledge_base:
                self.knowledge_base[category] = []
            
            self.knowledge_base[category].append({
                'question': question,
                'answer': answer,
                'keywords': keywords or []
            })
            
            with open('backend/ai/knowledge_base.json', 'w', encoding='utf-8') as f:
                json.dump(self.knowledge_base, f, ensure_ascii=False, indent=2)
            
            return True
        except Exception as e:
            print(f"Erreur lors de l'ajout de la question: {e}")
            return False

    def get_statistics(self) -> Dict:
        stats = {
            'total_questions': 0,
            'categories': {},
            'cache_hits': cache.get('qa_cache_hits', 0),
            'cache_misses': cache.get('qa_cache_misses', 0)
        }
        
        for category, entries in self.knowledge_base.items():
            stats['categories'][category] = len(entries)
            stats['total_questions'] += len(entries)
        
        return stats

    def _calculate_similarity(self, str1, str2):
        return SequenceMatcher(None, str1.lower(), str2.lower()).ratio()

    def _find_best_match(self, question, category=None):
        best_match = None
        highest_similarity = 0
        best_category = None

        # Si une catégorie est spécifiée, chercher uniquement dans cette catégorie
        categories_to_search = [category] if category else self.knowledge_base.keys()

        for cat in categories_to_search:
            if cat in self.knowledge_base:
                for key, answer in self.knowledge_base[cat].items():
                    # Calculer la similarité avec la question complète
                    similarity = self._calculate_similarity(question, key)
                    # Calculer aussi la similarité avec des mots-clés importants
                    keywords = question.lower().split()
                    for keyword in keywords:
                        keyword_similarity = self._calculate_similarity(keyword, key)
                        similarity = max(similarity, keyword_similarity)
                    
                    if similarity > highest_similarity:
                        highest_similarity = similarity
                        best_match = answer
                        best_category = cat

        # Seuil de similarité réduit pour plus de flexibilité
        if highest_similarity > 0.2:
            return best_match, best_category
        return None, None

    def get_answer(self, question, context=None, language="fr"):
        try:
            # Extraire la catégorie potentielle de la question
            category = None
            question_lower = question.lower()
            
            # Détection de catégorie plus précise avec plus de mots-clés
            if any(word in question_lower for word in ["international", "étranger", "visa", "traduction", "assurance", "étudiant étranger"]):
                category = "international"
            elif any(word in question_lower for word in ["inscription", "frais", "campus", "formation", "stage", "général"]):
                category = "general"
            elif any(word in question_lower for word in ["ordinateur", "logiciel", "moodle", "teams", "git", "vpn", "technique"]):
                category = "technique"
            elif any(word in question_lower for word in ["formation", "bachelor", "mastère", "mba", "spécialisation", "alternance", "sin", "spécialité"]):
                category = "formations"
            elif any(word in question_lower for word in ["campus", "ville", "localisation", "équipement", "innovation", "école"]):
                category = "campus"
            elif any(word in question_lower for word in ["admission", "inscription", "frais", "financement", "bourse", "inscrire"]):
                category = "admission"
            elif any(word in question_lower for word in ["événement", "portes ouvertes", "job dating", "conférence", "évènement"]):
                category = "evenements"
            elif any(word in question_lower for word in ["carrière", "métier", "débouché", "salaire", "entreprise", "emploi"]):
                category = "carrieres"
            elif any(word in question_lower for word in ["lab", "innovation", "projet", "mydil", "mydatalab", "laboratoire"]):
                category = "innovation"

            answer, matched_category = self._find_best_match(question, category)
            
            if answer:
                return answer
            else:
                return "Je ne peux pas répondre à cette question pour le moment. Veuillez reformuler ou contacter le service étudiant."
        except Exception as e:
            return "Désolé, une erreur s'est produite. Veuillez réessayer." 