import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) =>Padding(
    padding: EdgeInsets.symmetric(horizontal: 45),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: customTextGrey),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              hintText: 'Ache o que precisa...',
              hintStyle: TextStyle(fontSize: 14, color: customTextGrey),
              fillColor: customLightGrey,
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
        ),
        const SizedBox(width: 10),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: customBlue,
            borderRadius: BorderRadius.circular(12)
          ),
          child: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.search_rounded, color: customLightGrey, size: 25,)
          ),
        )
      ],
    )
  );
}