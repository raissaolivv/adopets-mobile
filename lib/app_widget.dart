
import 'package:adopets/app_controller.dart';
import 'package:adopets/login_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget{
  const AppWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance, 
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Adopets",
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(218, 196, 176, 1.0),
            brightness: AppController.instance.isDartTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          home: LoginPage(),
    );
      });
  }

  
}