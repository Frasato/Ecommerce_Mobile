import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/styles/buttonStyle.dart';
import 'package:ecommerce_app/styles/textButtonStyle.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfController = TextEditingController();

  void _saveInformationsRegister() async{

    if(_nameController.text.isEmpty || 
      _emailController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _cpfController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Os campos devem ser preenchidos corretamente')));
        return;
      }

    final response = await AuthService.register(_nameController.text, _passwordController.text, _emailController.text, _cpfController.text, _phoneController.text);

    if(response) Navigator.pushReplacementNamed(context, "/login");
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Nome Completo',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu nome completo' : null,
                    icon: Icons.person
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu email' : null,
                    icon: Icons.email
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _phoneController,
                    hintText: 'Telefone',
                    validator: (value) => value == null || value.isEmpty ? 'Informe um telefone válido' : null,
                    icon: Icons.phone
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _cpfController,
                    hintText: 'CPF',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu CPF' : null,
                    icon: Icons.credit_card
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Senha',
                    validator: (value) => value == null || value.isEmpty ? 'Informe a senha' : null,
                    icon: Icons.lock
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _saveInformationsRegister,
                    style: buttonStyle,
                    child: Text('Continuar')
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
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