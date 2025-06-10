import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatService {

  Future<void> generateChat() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$apiUrl/chat/$userId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
    );

    if(response.statusCode == 201){
      final decode = jsonDecode(response.body);
      prefs.setString('chatId', decode['chatId']);
      return;
    }

    throw Exception('Error, chat can not be created!');
  }

}