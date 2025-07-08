import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/styles/buttonStyle.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
    String street = _street.text;
    String number = _number.text;
    String state = _state.text;
    String district = _district.text;
    String city = _city.text;
    String cep = _cep.text;

    if(street.isEmpty || number.isEmpty || city.isEmpty || cep.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Os campos devem ser preenchidos corretamente')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await AuthService.registerAddress(street, number, state, district, city, cep);

    setState(() {
      _isLoading = false;
    });

    if(response) Navigator.pushReplacementNamed(context, '/login');
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
                    controller: _district,
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
                    controller: _state,
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
                ],
              )
            )
          ],
        ),
      ),
    ),
  );
}