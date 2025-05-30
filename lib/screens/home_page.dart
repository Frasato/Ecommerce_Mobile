import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:ecommerce_app/widgets/header.dart';
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
      backgroundColor: Colors.lightBlue,
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
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            child: Text('Banner para promoções'),
          ),
          SizedBox(height: 20),
          CustomTextField()
        ],
      ),
    ) 
  );
}