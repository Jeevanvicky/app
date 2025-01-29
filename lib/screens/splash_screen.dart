import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Function to get device info and send it to the backend
  Future<void> sendDeviceInfoToBackend() async {
    try {
      // Collect device information
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      // Create device info data to send to API
      Map<String, dynamic> deviceData = {
        'deviceType': 'android',
        'deviceId': androidInfo.id,
        'deviceName': androidInfo.model,
        'deviceOSVersion': androidInfo.version.release,
        'deviceIPAddress': '11.433.445.66',  // Replace with actual IP if needed
        'lat': 9.9312,
        'long': 76.2673,
        'buyer_gcmid': '',
        'buyer_pemid': '',
        'app': {
          'version': '1.20.5',
          'installTimeStamp': '2022-02-10T12:33:30.696Z',
          'uninstallTimeStamp': '2022-02-10T12:33:30.696Z',
          'downloadTimeStamp': '2022-02-10T12:33:30.696Z',
        },
      };

      // Send device info to the backend
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(deviceData),
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Device info sent successfully');
      } else {
        print('Failed to send device info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending device info: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    sendDeviceInfoToBackend();  // Call the function to send device info
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
