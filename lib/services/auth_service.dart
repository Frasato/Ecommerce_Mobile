import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static Future<bool> register(
    String name,
    String password,
    String email,
    String cpf,
    String street,
    String number,
    String city,
    String cep
  ) async{
    
    if(name.isEmpty || password.isEmpty || email.isEmpty || cpf.isEmpty || street.isEmpty || number.isEmpty || city.isEmpty || cep.isEmpty){
      return false;
    }

    final response = await http.post(
      Uri.parse(''),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
        'email': email,
        'cpf': cpf,
        'street': street,
        'number': number,
        'city': city,
        'CEP': cep
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
      Uri.parse(''),
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

      return token;
    }

    return null;
  }
}