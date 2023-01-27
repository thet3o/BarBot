import 'package:barbot_manager/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'BarBot',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login':(context) => LoginScreen()
      },
    )
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Working'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }, 
              child: const Text('click')
            )
          ],
        ),
      ),
    );
  }
}
