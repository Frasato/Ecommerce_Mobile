import 'dart:convert';
import 'package:ecommerce_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static Future<bool> register(
    String? name,
    String? password,
    String? email,
    String? cpf,
    String? phone,
  ) async{
    
    if(name == null || password == null || email == null || cpf == null){
      return false;
    }

    final response = await http.post(
      Uri.parse('$apiUrl/auth/register'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
        'email': email,
        'phone': phone,
        'cpf': cpf,
      })
    );

    if(response.statusCode == 201){
      return true;
    }

    return false;
  }

  static Future<String?> login(String email, String password) async{
    if(email.isEmpty || password.isEmpty){
      return null;
    }

    final response = await http.post(
      Uri.parse('$apiUrl/auth/login'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password
      })
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      String userName = data['name'];
      String token = data['token'];
      String userId = data['userId'];

      if(token == ''){
        return null;
      }

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('userName', userName);
      prefs.setString('userId', userId);
      return token;
    }

    return null;
  }

  static Future<bool> registerAddress(String street, String number, String countryState, String district, String city, String cep) async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    final response = await http.post(
      Uri.parse('$apiUrl/auth/address/$userId'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode({
        'street': street,
        'number': number,
        'countryState': countryState,
        'district': district,
        'city': city,
        'CEP': cep
      })
    );

    if(response.statusCode == 201) return true;

    return false;
  }
}