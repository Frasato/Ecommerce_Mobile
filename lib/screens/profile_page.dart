import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:ecommerce_app/styles/blue_subtitle_text.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  late Future<Map<String, dynamic>> _profielFuture;

  @override
  void initState() {
    super.initState();
    _profielFuture = UserService().getSingleUser();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: CustomDrawerNavigation(),
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(
        color: customLightGrey,
      ),
    ),
    body: Column(
      children: [
        Header(),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
          future: _profielFuture,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }

            final user = snapshot.data;
            final address = user!['address'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Perfil', style: blueSubtitleTextStyle,),
                SizedBox(height: 15),
                Text(user['name']),
                SizedBox(height: 6),
                Text(user['email']),
                SizedBox(height: 6),
                Text(user['cpf']),
                SizedBox(height: 25),
                Text('Endereço', style: blueSubtitleTextStyle,),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('${address['street']}, '),
                    Text(address['number'])
                  ],
                ),
                SizedBox(height: 6),
                Text(address['city']),
                SizedBox(height: 6),
                Text(address['cep']),
                SizedBox(height: 6),
              ],
            );
          }
        ) 
        ),
      ],
    ),
  );
}