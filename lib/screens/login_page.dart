import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/styles/buttonStyle.dart';
import 'package:ecommerce_app/styles/textButtonStyle.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async{
    if(!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String? response = await AuthService.login(
      _emailController.text,
      _passwordController.text
    );

    setState(() {
      _isLoading = false;
    });

    if(response != null){
      Navigator.pushReplacementNamed(context, '/home');
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos'))
      );
    }
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
                    Text('Bem-vindo', style: TextStyle(
                      color: customLightGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      height: 0.8
                    )),
                    Text('de volta', style: TextStyle(color: customLightGrey, fontWeight: FontWeight.w900, fontSize: 25))
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
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) => value == null || value.isEmpty ? 'Informe seu email' : null,
                    icon: Icons.email
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
                    onPressed: _login,
                    style: buttonStyle,
                    child: Text('Entrar')
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    style: textButtonStyle,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Não tem conta?'),
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
    ) 
  );
}