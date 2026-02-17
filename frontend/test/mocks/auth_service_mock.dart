import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Needed for Encoding

class MockAuthService extends Mock implements http.Client {
  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding, // Add this parameter
  }) {
    return Future.value(http.Response(
      '{"message": "User created successfully"}',
      201,
    ));
  }
}