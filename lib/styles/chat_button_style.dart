import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle chatButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: customYellow,
  elevation: 0,
  minimumSize: Size(80, 50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))
  ),
  textStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20
  ),
  foregroundColor: customTextGrey
);