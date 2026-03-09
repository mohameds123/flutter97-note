import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';


class TextFormFiledWidget extends StatefulWidget {
  TextEditingController controller;
  String hintTxt;
  TextInputType keyType;
  Widget ? suffIcon ;
  bool ? obscureText;
  EdgeInsetsGeometry ? contentPadding;
  TextFormFiledWidget({super.key,required this.controller,required this.hintTxt, required this.keyType, this.suffIcon, this.obscureText,this.contentPadding});

  @override
  State<TextFormFiledWidget> createState() => _TextFormFiledWidgetState();
}

class _TextFormFiledWidgetState extends State<TextFormFiledWidget> {
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(

        onTap: () {},
        controller: widget.controller,
        cursorColor: Colors.white,
        style: TextStyle(
            color: Colors.white
        ),
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          filled: true,
          fillColor: ColorsManager.marron,
          border: InputBorder.none,
          hintText: widget.hintTxt,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          suffixIcon: widget.suffIcon,
        ),
        keyboardType: widget.keyType,
      ),
    );
  }
}