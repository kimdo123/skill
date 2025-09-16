import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/rest_api.dart';

class APITestScreen extends StatefulWidget {
  const APITestScreen({super.key});

  @override
  State<APITestScreen> createState() => _APITestScreenState();
}

class _APITestScreenState extends State<APITestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: getUser,
              child: Text('getUser', style: TextStyle(fontSize: 100)),
            ),
          ),
        ],
      ),
    );
  }

  String accessToken = 'ehgus';

  Future<void> getUser() async {
    try {
      final result = await api(
        'get',
        'http://192.168.219.49/authenticate/profile',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      print('결과: ${result['data']['mberId']}');
    } catch (e) {
      print('에러: $e');
    }
  }
}
