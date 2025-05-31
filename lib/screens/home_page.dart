import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: CustomDrawerNavigation(),
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(
        color: Colors.white
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
                  style: TextStyle(fontWeight: FontWeight.w700, color: customBlue),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ) 
  );
}