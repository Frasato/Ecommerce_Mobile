import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget{
  final String productId;

  const ProductPage({
    super.key,
    required this.productId
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(),
    ),
  );
}