import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
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
    body: Column(
      children: [],
    ),
  );
}