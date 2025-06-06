import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/styles/blue_subtitle_text.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:ecommerce_app/widgets/footer.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  late Future<List<Map<String, dynamic>>> _productsFuture;
  late Future<List<Map<String, dynamic>>> _productsCosmeticsFuture;
  late Future<List<Map<String, dynamic>>> _productsFitnessFuture;

  @override
  void initState(){
    super.initState();
    _productsFuture = ProductService().getAllProducts();
    _productsCosmeticsFuture = ProductService().getProductByCategory('Beleza');
    _productsFitnessFuture = ProductService().getProductByCategory('Fit');
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
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Column(
        children: [
          Header(),
          SizedBox(height: 50),
          Container(
            width: 350,
            height: 110,
            decoration: BoxDecoration(
              color: customYellow,
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            child: Text('Banner para promoções'),
          ),
          const SizedBox(height: 20),
          CustomTextField(),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  'Mais vendidos',
                  style: blueSubtitleTextStyle,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
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
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length > 5? 5 : products.length,
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  'Produtos',
                  style: blueSubtitleTextStyle,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  'Cosméticos',
                  style: TextStyle(fontWeight: FontWeight.w500, color: customTextGrey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _productsCosmeticsFuture,
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
                      itemCount: products.length > 5? 5 : products.length,
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
                ),    
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  'Fitness',
                  style: TextStyle(fontWeight: FontWeight.w500, color: customTextGrey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _productsFitnessFuture,
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
                      itemCount: products.length > 5? 5 : products.length,
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
                ),
                
              ),
            ],
          ),
          SizedBox(height: 30),
          Footer()
        ],
      ),
    ) 
  );
}