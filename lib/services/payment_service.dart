import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentService {

  static Future<Map<String, dynamic>> pixPayment(String userId, String orderId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$apiUrl/payment/pix'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode({
        'userId': userId,
        'orderId': orderId
      })
    );

    if(response.statusCode == 201){
      return Map<String, dynamic>.from(jsonDecode(response.body));
    }else{
      throw Exception('Erro ao processar pagamento');
    }
  }

  static Future<void> cardPayment(String userId, String orderId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.post(
      Uri.parse('$apiUrl/payment/card'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode({
        'userId': userId,
        'orderId': orderId
      })
    );
  }

}