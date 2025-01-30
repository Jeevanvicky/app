import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'otp.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  void login() async {
    final response = await apiService.login(emailController.text, passwordController.text);
    if (response['status'] == 'success') {
      Get.to(() => const OtpScreen());
    } else {
      Get.snackbar("Error", response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(hintText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(hintText: "Password"), obscureText: true),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            TextButton(onPressed: () => Get.to(() => const RegisterScreen()), child: const Text("Register"))
          ],
        ),
      ),
    );
  }
}
