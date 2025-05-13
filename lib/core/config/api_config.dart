import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl => dotenv.env['API_URL'] ?? 'https://interview.mattlabz.tech';
  static String get token => dotenv.env['API_TOKEN'] ?? 'TOKEN-TEST-AFINZ';
  
  static const int defaultAgency = 3212;
  static const int defaultAccount = 9073;
  
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> get authHeaders => {
    ...headers,
    'Authorization': 'Bearer $token',
  };
} 