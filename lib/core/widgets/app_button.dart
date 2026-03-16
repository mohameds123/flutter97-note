import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Function function;
  double? buttonWidth;
  String buttonTxt;
   AppButton({super.key, required this.function, this.buttonWidth, required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        function();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: buttonWidth ?? 312,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child:  Center(
          child:  Text(
            buttonTxt,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
