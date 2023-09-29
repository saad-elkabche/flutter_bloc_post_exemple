import 'package:flutter/material.dart';



class MyButton extends StatelessWidget {
  String label;
  void Function() onclick;
  Color? buttonColor;
  
  MyButton({required this.label,required this.onclick,this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(label),
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 7),
        textColor: Colors.white,
        color: buttonColor ?? Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        onPressed: onclick,

    );
  }
}
