import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://example.com/api";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'email': email, 'password': password, 'phone': phone},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      body: {'phone': phone, 'otp': otp},
    );
    return jsonDecode(response.body);
  }
}
