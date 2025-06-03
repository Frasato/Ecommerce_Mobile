import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      color: customBlue
    ),
    child: Center(
      child: Image(
        image: AssetImage('assets/icon.png'),
        width: 50,
        height: 50,
      ),
    ),
  );
}