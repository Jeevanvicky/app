import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _referralController = TextEditingController();

  Future<void> registerUser(String email, String referralCode) async {
    final response = await http.post(
      Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/email/referral'),  // Updated API endpoint
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'referral_code': referralCode}),  // Sending email and referral code
    );

    if (response.statusCode == 200) {
      // Registration successful, navigate to Home screen
      Navigator.pushNamed(context, '/home');
    } else {
      // Handle error if registration fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,  // Email keyboard type
            ),
            TextField(
              controller: _referralController,
              decoration: InputDecoration(labelText: 'Referral Code'),
            ),
            ElevatedButton(
              onPressed: () {
                registerUser(_emailController.text, _referralController.text);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
