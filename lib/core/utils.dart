import 'package:flutter/material.dart';




void showSnackBar(BuildContext context,String text,Color color){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:Text(text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.white),
      ),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
    )
  );
}

void showProgressBar(BuildContext context){
  Widget circuleProgressBar=Center(
    child: Container(
      width: 90,
      height: 90,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9)
      ),
      child:const  Center(
          child: CircularProgressIndicator(color: Colors.lightBlueAccent)),
    ),
  );

  showDialog(context: context,
      builder: (context)=>circuleProgressBar,
    barrierDismissible: false
  );
}

void hideProgressBar(BuildContext context){
  Navigator.of(context).pop();
}