import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ApiService apiService = ApiService();

  void register() async {
    final response = await apiService.register(emailController.text, passwordController.text, phoneController.text);
    if (response['status'] == 'success') {
      Get.to(() => const OtpScreen());
    } else {
      Get.snackbar("Error", response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          TextField(controller: emailController, decoration: const InputDecoration(hintText: "Email")),
          TextField(controller: passwordController, decoration: const InputDecoration(hintText: "Password"), obscureText: true),
          TextField(controller: phoneController, decoration: const InputDecoration(hintText: "Phone")),
          ElevatedButton(onPressed: register, child: const Text("Register"))
        ],
      ),
    );
  }
}
