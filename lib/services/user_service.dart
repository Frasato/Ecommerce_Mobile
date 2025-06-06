import 'dart:convert';
import 'package:ecommerce_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  
  Future<Map<String, dynamic>> getSingleUser() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    final response = await http.get(
      Uri.parse('$apiUrl/user/$userId'),
      headers: {
        'Contet-Type':'application/json',
        'Authorization':'Bearer $token'
      },
    );

    if(response.statusCode == 200){
      final decoded = jsonDecode(response.body);
      return Map<String, dynamic>.from(decoded);
    }

    throw Exception('Erro: Usuário não encontrado!');
  }
}