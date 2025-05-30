import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {

  static Future<void> createOrder(String userId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.post(
      Uri.parse('$apiUrl/order'),
      headers: {
        'Contet-Type':'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode({
        'userId': userId
      })
    );
  }

  static Future<List<Map<String, dynamic>>> getAllOrdersByUser(String userId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/order/user/$userId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }else{
      throw Exception('Ordem não encontrada');
    }
  }

}