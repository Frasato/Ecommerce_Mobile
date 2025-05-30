import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {

  Future<List<Map<String, dynamic>>> getAllProducts() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    final response = await http.get(
      Uri.parse('$apiUrl/product'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }else{
      throw Exception('Falha ao carregar produtos');
    }
  }

}