import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartService {

  static Future<Map<String, dynamic>> takeCart(String? userId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/cart/$userId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      final cartData = Map<String, dynamic>.from(jsonDecode(response.body));
      prefs.setString('cartId', cartData['id']);

      return cartData;
    }else{
      throw Exception('Erro ao carregar carrinho de compras');
    }
  }

  static Future<List<Map<String, dynamic>>> getProductsOnCart() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    final cartData = await takeCart(userId);

    List<dynamic> cartItems = cartData['cartItem'] ?? [];

    return cartItems.map((item) => {
      'product': Map<String, dynamic>.from(item['product']),
      'quantity': item['quantity'],
      'cartItemId': item['id'],
    }).toList();
    
  }

  static Future<void> removeItemFromCart(String cartItemId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.put(
      Uri.parse('$apiUrl/cart/$cartItemId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );
  }

  static Future<void> addItemOnCart(String productId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    if(userId == null) throw Exception('User should not be null: $userId');

    await http.post(
      Uri.parse('$apiUrl/cart'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode({
        'userId': userId,
        'productId': productId
      })
    );
  }

  static Future<void> clearCart(String cartId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.put(
      Uri.parse('$apiUrl/cart/clear/$cartId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );
  }

  static Future<double> getCartTotal() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    final cartData = await takeCart(userId);
    final value = cartData['totalPrice'] ?? 0;
    double finalValue = value / 100;
    return finalValue;
  }

  static Future<void> plusOneCartItem(String cartItemId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$apiUrl/cart/plus/$cartItemId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      return;
    }

    throw Exception('Erro ao somar os itens no carrinho');
  }

  static Future<void> minusOneCartItem(String cartItemId) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$apiUrl/cart/minus/$cartItemId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      return;
    }

    throw Exception('Erro ao somar os itens no carrinho');
  }
}