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
      final decoded = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(decoded['products']);
    }else{
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<List<Map<String, dynamic>>> getProductByCategory(String category) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/product/cat/$category'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      final decoded = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(decoded['products']);
    }else{
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<Map<String, dynamic>> getProductById(String productId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print('Entrou aqui, token: ${token}');

    final response = await http.get(
      Uri.parse('$apiUrl/product/$productId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
    );

    if(response.statusCode == 200){
      print('response: ${response.statusCode}');
      final decoded = jsonDecode(response.body);
      return Map<String, dynamic>.from(decoded['product']);
    }else{
      throw Exception('Falha ao carregar o produto');
    }
  }

  Future<List<Map<String, dynamic>>> getPurchaseProduct() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/product/purchase'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
    );

    if(response.statusCode == 200){
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }else{
      throw Exception('Falha ao carregar o produtos');
    }
  }
}