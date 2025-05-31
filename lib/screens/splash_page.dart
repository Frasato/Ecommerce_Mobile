import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{

  @override
  void initState(){
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if(token == '' || token == null){
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Container(
        child: Column(
          children: [
            Image(image: AssetImage('assets/icon.png')),
            SizedBox(height: 16),
            CircularProgressIndicator()
          ],
        ),
      )
    )
  );
}