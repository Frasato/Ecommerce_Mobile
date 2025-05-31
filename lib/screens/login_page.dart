import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

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
                    Text('Bem-vindo', style: TextStyle(color: customLightGrey, fontWeight: FontWeight.bold, fontSize: 25)),
                    Text('de volta', style: TextStyle(color: customLightGrey, fontWeight: FontWeight.bold, fontSize: 25))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ) 
  );
}