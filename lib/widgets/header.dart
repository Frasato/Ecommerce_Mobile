import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  const Header({super.key});

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [
      Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: customBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)
          )
        ),
      ),
      Positioned(
        top: 0,
        child: Image(
          image: AssetImage('assets/icon.png'),
          width: 80,
          height: 80,
        )
      )
    ],
  );
}