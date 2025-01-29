import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();

  Future<void> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('https://devapiv4.dealsdray.com/api/v2/user/otp'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({'phone': phone}),
    );

    if (response.statusCode == 200) {
      // Navigate to OTP screen
      Navigator.pushNamed(context, '/otp', arguments: phone);
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Stack(
        children: [
          // Online background image
          Positioned.fill(
            child: Image.network(
              'https://your-image-url.com/login_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => sendOtp(_phoneController.text),
                  child: Text('Send OTP'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
