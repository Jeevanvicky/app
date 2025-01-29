import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://devapiv4.dealsdray.com/api/v2/user/";

  static Future<Map<String, dynamic>?> addDevice(String deviceInfo) async {
    final response = await http.post(
      Uri.parse("${baseUrl}device/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"device_info": deviceInfo}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> requestOtp(String mobile) async {
    final response = await http.post(
      Uri.parse("${baseUrl}otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": mobile}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyOtp(String mobile, String otp) async {
    final response = await http.post(
      Uri.parse("${baseUrl}otp/verification"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": mobile, "otp": otp}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> registerUser(String email, String referral) async {
    final response = await http.post(
      Uri.parse("${baseUrl}email/referral"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "referral": referral}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
