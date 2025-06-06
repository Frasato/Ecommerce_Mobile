import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/styles/buttonStyle.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget{
  final String productId;
  final String productCategory;

  const ProductPage({
    super.key,
    required this.productId,
    required this.productCategory
  });

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>{
  late Future<Map<String, dynamic>> _productFuture;
  late Future<List<Map<String, dynamic>>> _productsCategoryFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductService().getProductById(widget.productId);
    _productsCategoryFuture = ProductService().getProductByCategory(widget.productCategory);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(
        color: customLightGrey
      ),
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Header(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: _productFuture, 
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                      return Center(child: Text('Erro ao carregar produtos'));
                    }
                    final product = snapshot.data;
                    double price(){
                      double price;

                      if(product!['price'] > product['priceWithDiscount'] && product['priceWithDiscount'] > 0){
                        int value = product['priceWithDiscount'];
                        price = value / 100;
                      }else{
                        int value = product['price'];
                        price = value / 100;
                      }

                      return price;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Image.network(product!['image'], width: 350, height: 350, fit: BoxFit.cover),
                        Text(product['name'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
                        Text('R\$${price().toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                        SizedBox(height: 35),
                        ElevatedButton(onPressed: (){}, style: buttonStyle, child: Text('Comprar'),),
                        TextButton(
                          onPressed: () => CartService.addItemOnCart(product['id']),
                          child: Row(
                            children: [
                              Icon(Icons.add_shopping_cart_rounded),
                              Text('Adicionar ao Carrinho')
                            ],
                          )
                        ),
                        SizedBox(height: 20),
                        Text('Sobre o produto', style: TextStyle(fontWeight: FontWeight.w700, color: customBlue, fontSize: 22),),
                        Text(product['description'], style: TextStyle(color: customTextGrey, fontSize: 22),),
                        SizedBox(height: 20),
                        Text('Informações', style: TextStyle(fontWeight: FontWeight.w700, color: customBlue, fontSize: 22)),
                        Text('Produtor: ${product['producer']}'),
                        Text('Código de barras: ${product['barCode']}'),
                        Text('Categoria: ${product['category']}')
                      ],
                    );
                  } 
                ),
                SizedBox(height: 20),
                Text('Produtos Relacionados', style: TextStyle(color: customBlue, fontWeight: FontWeight.w700, fontSize: 22),),
                SizedBox(
                  height: 250,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _productsCategoryFuture,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(snapshot.hasError){
                        return Center(child: Text('Erro ao carregar produtos'));
                      }
                      final products = snapshot.data ?? [];
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length > 10 ? 10 : products.length,
                        itemBuilder: (context, index){
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onTap: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (_) => ProductPage(productId: product['id'], productCategory: product['category'],)
                                )
                              );
                            }
                          );
                        }
                      );
                    }
                  )
                ),
                SizedBox(height: 20)
              ],
            ), 
          ),
        ],
      )
    ),
  );
}