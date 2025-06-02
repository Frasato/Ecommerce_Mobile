import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData icon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.icon
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    style: TextStyle(color: customTextGrey),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      prefixIconColor: customTextGrey,
      hintText: hintText,
      hintStyle: TextStyle(color: customTextGrey),
      fillColor: customLightGrey,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none
      ),
      errorStyle: TextStyle(
        color: customRed,
      )
    ),
    validator: validator,
  );
}