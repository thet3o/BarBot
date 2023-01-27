import 'dart:convert';
import 'dart:io';

import 'package:barbot_manager/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});

  TextEditingController usernameFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  late var authResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login Page'),
            TextFormField(
              controller: usernameFieldController,
              decoration: const InputDecoration(
                labelText: 'Username'
              ),
            ),
            TextFormField(
              controller: passwordFieldController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: 'Password'
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                
              }, 
              child: const Text('Login')
            ),
            ElevatedButton(
              onPressed: () async{
                var response = await http.get(
                  Uri.parse('http://127.0.0.1:8000/auth/users/me'),
                  headers: <String, String>{
                    'Authorization': 'Bearer ${authResponse.accessToken}'
                  },
                );
                print(response.body);
              }, 
              child: const Text('Back')
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Back')
            )
          ],
        )
      ),
    );
  }

}