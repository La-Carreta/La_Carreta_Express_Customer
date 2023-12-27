import 'package:flutter/material.dart';

class InputDecorations {
  
  static InputDecoration authInputDecoration(
    {required String hintText,
    required String labelText,
    IconData? prefixIcon,
    required ColorScheme colors}) {


    Color mainColor = colors.primary;
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),

      border: UnderlineInputBorder(
        borderSide: BorderSide(color:mainColor),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(
        prefixIcon,
        color: mainColor,
      )
    );
  }

  static InputDecoration authPasswordInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon,
      required IconData suffixIcon,
      required Function() onPressed,
      required ColorScheme colors}) {
    Color mainColor = const Color(0xff023E8A);
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          prefixIcon,
          color: mainColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          color: mainColor,
          onPressed: () => onPressed(),
        ));
  }

  static InputDecoration serviceInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.indigo) : null,
    );
  }
}