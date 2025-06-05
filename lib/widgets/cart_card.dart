import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/styles/iconButtonStyle.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget{
  final String imageUri;
  final String productName;
  final double productPrice;
  final int quantity;
  final String cartItemId;
  final Future<void> Function() removeItem;
  final Future<void> Function() plusItem;
  final Future<void> Function() minusItem;
  
  const CartCard({
    super.key,
    required this.imageUri,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.cartItemId,
    required this.removeItem,
    required this.plusItem,
    required this.minusItem
  });

  

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(18, 56, 56, 56),
            blurRadius: 13.0,
            offset: Offset(10, 6)
          )
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              imageUri,
              height: 110,
              width: 110,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName.length > 25? '${productName.substring(0, 25)}...' : productName
                ),
                Text('R\$${productPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: plusItem,
                  style: iconButtonStyle,
                  icon: Icon(Icons.add)
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: customLightGrey
                  ),
                  child: Text('$quantity', style: TextStyle(fontSize: 18),),
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: minusItem,
                  style: iconButtonStyle,
                  icon: Icon(Icons.remove)
                )
              ],
            ),
            IconButton(
              onPressed: () => removeItem,
              icon: Icon(Icons.restore_from_trash)
            )
          ],
        ),
      ), 
    )
  );
}