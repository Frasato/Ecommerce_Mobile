import 'package:ecommerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  double price(){
    double price;

    if(product['price'] > product['priceWithDiscount'] && product['priceWithDiscount'] > 0){
      int value = product['priceWithDiscount'];
      price = value / 100;
    }else{
      int value = product['price'];
      price = value / 100;
    }
    
    return price;
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 250,
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
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: Image.network(product['image'], fit: BoxFit.cover,),
              ),
              const SizedBox(height: 6),
              Text(product['name'], maxLines: 2, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 0),
              Row(
                children: [
                  Text('R\$${price().toStringAsFixed(2)}'),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () => CartService.addItemOnCart(product['id']),
                    icon: Icon(Icons.add_shopping_cart_rounded)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ) 
  );
}