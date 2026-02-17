import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:8000';
  static const String _tokenKey = 'authToken';

  // Identifiants de test temporaires
  static const String _testEmail = 'test@epsi.fr';
  static const String _testPassword = 'test123';

  // Récupérer le token stocké
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Sauvegarder le token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Supprimer le token (déconnexion)
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Vérifier si l'utilisateur est connecté
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // Signup
  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        return {
          'success': true,
          'message': 'Compte créé avec succès',
          'user': data['user'],
        };
      } else {
        return {
          'success': false,
          'message': data['error'] ?? 'Une erreur est survenue',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur',
      };
    }
  }

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Vérification des identifiants de test
    if (email == _testEmail && password == _testPassword) {
      // Simuler un délai réseau
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Créer un token de test
      const testToken = 'test_token_123';
      await saveToken(testToken);
      
      return {
        'success': true,
        'message': 'Connexion réussie',
        'token': testToken,
        'user': {
          'id': 1,
          'name': 'Utilisateur Test',
          'email': _testEmail,
        },
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // Sauvegarder le token
        await saveToken(data['token']);
        return {
          'success': true,
          'message': 'Connexion réussie',
          'user': data['user'],
        };
      } else {
        return {
          'success': false,
          'message': data['error'] ?? 'Une erreur est survenue',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur',
      };
    }
  }

  // Logout
  Future<void> logout() async {
    await deleteToken();
  }

  // Faire une requête authentifiée
  static Future<http.Response> authenticatedRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Non authentifié');
    }

    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };

    final requestHeaders = headers != null
        ? {...defaultHeaders, ...headers}
        : defaultHeaders;

    final uri = Uri.parse('$_baseUrl$endpoint');

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: requestHeaders);
      case 'POST':
        return await http.post(
          uri,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'PUT':
        return await http.put(
          uri,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'DELETE':
        return await http.delete(uri, headers: requestHeaders);
      default:
        throw Exception('Méthode HTTP non supportée');
    }
  }
}