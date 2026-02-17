from django.test import TestCase, RequestFactory
from django.core.cache import cache
from .services import QAService, rate_limit
import json
import os

class QAServiceTest(TestCase):
    def setUp(self):
        self.qa_service = QAService()
        self.factory = RequestFactory()
        cache.clear()

    def test_load_knowledge_base(self):
        """Test le chargement de la base de connaissances"""
        self.assertIsInstance(self.qa_service.knowledge_base, dict)
        self.assertGreater(len(self.qa_service.knowledge_base), 0)

    def test_get_answer_with_cache(self):
        """Test la récupération d'une réponse avec cache"""
        question = "Quelles sont les spécialisations du Bachelor SIN ?"
        
        # Premier appel (pas de cache)
        response1 = self.qa_service.get_answer(question)
        self.assertEqual(response1['status'], 'success')
        self.assertIn('answer', response1)
        
        # Deuxième appel (avec cache)
        response2 = self.qa_service.get_answer(question)
        self.assertEqual(response2['status'], 'success')
        self.assertEqual(response2['source'], 'cache')
        self.assertEqual(response1['answer'], response2['answer'])

    def test_get_answer_no_match(self):
        """Test la récupération d'une réponse sans correspondance"""
        question = "Question qui n'existe pas dans la base"
        response = self.qa_service.get_answer(question)
        self.assertEqual(response['status'], 'error')
        self.assertEqual(response['source'], 'no_match')

    def test_rate_limit(self):
        """Test la limitation de taux"""
        @rate_limit(requests_per_minute=2)
        def test_view(request):
            return {'status': 'success'}

        # Créer une requête
        request = self.factory.get('/')
        request.META['REMOTE_ADDR'] = '127.0.0.1'

        # Premier appel
        response1 = test_view(request)
        self.assertEqual(response1['status'], 'success')

        # Deuxième appel
        response2 = test_view(request)
        self.assertEqual(response2['status'], 'success')

        # Troisième appel (devrait être limité)
        response3 = test_view(request)
        self.assertEqual(response3['status'], 'error')
        self.assertIn('error', response3)

    def test_add_question(self):
        """Test l'ajout d'une nouvelle question"""
        question = "Nouvelle question test"
        answer = "Réponse test"
        category = "test"
        keywords = ["test", "question", "nouvelle"]

        # Ajouter la question
        success = self.qa_service.add_question(question, answer, category, keywords)
        self.assertTrue(success)

        # Vérifier que la question a été ajoutée
        response = self.qa_service.get_answer(question)
        self.assertEqual(response['status'], 'success')
        self.assertEqual(response['answer'], answer)

    def test_get_statistics(self):
        """Test la récupération des statistiques"""
        stats = self.qa_service.get_statistics()
        self.assertIn('total_questions', stats)
        self.assertIn('categories', stats)
        self.assertIn('cache_hits', stats)
        self.assertIn('cache_misses', stats)

    def test_calculate_similarity(self):
        """Test le calcul de similarité"""
        str1 = "test question"
        str2 = "question test"
        similarity = self.qa_service._calculate_similarity(str1, str2)
        self.assertGreater(similarity, 0)
        self.assertLessEqual(similarity, 1)

    def tearDown(self):
        cache.clear()
