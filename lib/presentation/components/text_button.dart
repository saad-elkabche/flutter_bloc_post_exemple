import 'package:flutter/material.dart';





class MyTextButton extends StatelessWidget {
  String text1,text2;
  void Function() onclick;

  MyTextButton({required this.text1,required this.text2,required this.onclick});

  @override
  Widget build(BuildContext context) {
    return
        GestureDetector(
          onTap: onclick,
          child:  Text.rich(
            TextSpan(text: text1,
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: text2,style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline
                  ))
                ]
            ),

          ),
        );
  }
}
