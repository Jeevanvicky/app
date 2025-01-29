import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  String? phoneNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;
  }

  Future<void> verifyOtp(String otp) async {
    final response = await http.post(
      Uri.parse('https://devapiv4.dealsdray.com/api/v2/user/otp/verification'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({'phone': phoneNumber, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      // Navigate to home screen
      Navigator.pushNamed(context, '/home');
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Stack(
        children: [
          // Online background image
          Positioned.fill(
            child: Image.network(
              'https://your-image-url.com/otp_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _otpController,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => verifyOtp(_otpController.text),
                  child: Text('Verify OTP'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
