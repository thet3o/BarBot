import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'models/auth_response.dart';

class ApiClient{
  final String url;

  const ApiClient({required this.url});

  Future<String> login(String username, String pwd) async{
    late http.Response response;
    try {
        response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/token'),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': username, 'password': pwd}
      );
      if (response.statusCode == 401){
        return "Username or password not found";
      }
    } catch (e) {
      return "Unknown error";
    }
    var authResponse = AuthResponse.fromJson(jsonDecode(response.body));
    return authResponse.accessToken;
  }
}