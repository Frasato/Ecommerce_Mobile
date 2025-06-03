import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget{
  final String searchWord;
  
  const CatalogPage({
    super.key,
    required this.searchWord
  });

  @override
  State<StatefulWidget> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>{
  late Future<List<Map<String, dynamic>>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService().getAllProducts();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: CustomDrawerNavigation(),
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(
        color: customLightGrey
      ),
    ),
    body: Column(
      children: [
        Header(),
        SizedBox(height: 40),
          CustomTextField(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _productsFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasError){
                  return Center(child: Text('Erro ao carregar produtos'));
                }
                final products = snapshot.data ?? [];
                
                final filteredProducts = products.where((product){
                  final name = (product['name'] as String).toLowerCase();
                  return name.contains(widget.searchWord.toLowerCase());
                }).toList();
                
                final displayedProducts = filteredProducts.isEmpty? products : filteredProducts;

                if(filteredProducts.isEmpty){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto ${widget.searchWord} não encontrado')
                      )
                    );
                  });
                }

                return GridView.builder(
                  itemCount: displayedProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.75
                  ),
                  itemBuilder: (context, index){
                    final product = displayedProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (_) => ProductPage(productId: product['id'], productCategory: product['category'])
                          )
                        );
                      }
                    );
                  }
                );
              }
            ),
          )
        ],
      ),
    );
}