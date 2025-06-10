import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/styles/buttonStyle.dart';
import 'package:ecommerce_app/styles/textButtonStyle.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAddressPage extends StatefulWidget{
  const RegisterAddressPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterAddressPageState();
}

class _RegisterAddressPageState extends State<RegisterAddressPage>{
  final _formKey = GlobalKey<FormState>();
  final _street = TextEditingController();
  final _number = TextEditingController();
  final _state = TextEditingController();
  final _district = TextEditingController();
  final _city = TextEditingController();
  final _cep = TextEditingController();

  bool _isLoading = false;

  void _register() async{

    if(!_formKey.currentState!.validate()){
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? cpf = prefs.getString('cpf');
    String? phone = prefs.getString('phone');
    String street = _street.text;
    String number = _number.text;
    String state = _state.text;
    String district = _district.text;
    String city = _city.text;
    String cep = _cep.text;

    if(name == null || password == null || email == null || cpf == null || phone == null || street.isEmpty || number.isEmpty || city.isEmpty || cep.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Os campos devem ser preenchidos corretamente')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await AuthService.register(name, password, email, cpf, phone, street, number, state, district, city, cep);

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      width: double.infinity,
      height: 850,
      decoration: BoxDecoration(
        color: customBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/icon.png'),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, seja', style: TextStyle(
                      color: customLightGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      height: 0.8
                    )),
                    Text('bem-vindo', style: TextStyle(
                      color: customLightGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 25
                    ))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 70),
            _isLoading? CircularProgressIndicator(
              color: customYellow,
            ) :
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _street,
                    hintText: 'Endereço',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu endereço' : null,
                    icon: Icons.house
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _number,
                    hintText: 'Número',
                    validator: (value) => value == null || value.isEmpty ? 'Informe o número da residência' : null,
                    icon: Icons.numbers
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _city,
                    hintText: 'Bairro',
                    validator: (value) => value == null || value.isEmpty ? 'Informe o bairro' : null,
                    icon: Icons.house
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _city,
                    hintText: 'Cidade',
                    validator: (value) => value == null || value.isEmpty ? 'Informe sua cidade' : null,
                    icon: Icons.location_on
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _city,
                    hintText: 'Estado',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu estado' : null,
                    icon: Icons.location_city
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _cep,
                    hintText: 'CEP',
                    validator: (value) => value == null || value.isEmpty ? 'Informe o CEP' : null,
                    icon: Icons.share_location_rounded
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _register,
                    style: buttonStyle,
                    child: Text('Continuar')
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterAddressPage())),
                    style: textButtonStyle,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já tem conta?'),
                        const SizedBox(width: 5),
                        Text('Click aqui.', style: TextStyle(color: customYellow, decoration: TextDecoration.underline),)
                      ],
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    ),
  );
}