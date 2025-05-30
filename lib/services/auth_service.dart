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

    

  }
}