import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      width: 130,
      height: 185,
      decoration: BoxDecoration(
        color: customLightGrey,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(32, 56, 56, 56),
            blurRadius: 13.0,
            offset: Offset(10, 6)
          )
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/icon.png'),
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 20),
            Text('Farmacia Produto titulo 50g'),
            const SizedBox(height: 15),
            Row(
              children: [
                Text('R\$10,00'),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.add_shopping_cart_rounded)
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}