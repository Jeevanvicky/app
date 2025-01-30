import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final ApiService apiService = ApiService();

  void verifyOtp() async {
    final response = await apiService.verifyOtp("1234567890", otpController.text);
    if (response['status'] == 'success') {
      Get.snackbar("Success", "OTP Verified!");
    } else {
      Get.snackbar("Error", response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: otpController, decoration: const InputDecoration(hintText: "Enter OTP")),
          ElevatedButton(onPressed: verifyOtp, child: const Text("Verify OTP"))
        ],
      ),
    );
  }
}
