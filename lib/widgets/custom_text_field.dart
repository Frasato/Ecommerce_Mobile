import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) =>Padding(
    padding: EdgeInsets.symmetric(horizontal: 45),
    child: TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.search, size: 17),
        prefixIconColor: Colors.black,
        hintText: 'Ache o que precisa...',
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),
        errorStyle: TextStyle(
          color: Colors.amber,
          fontSize: 14
        )
      ),
    )
  );
}