import 'package:adopets/app_controller.dart';
import 'package:adopets/login_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Adota Um",
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(218, 196, 176, 1.0),
            brightness:
                AppController.instance.isDartTheme
                    ? Brightness.dark
                    : Brightness.light,
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(
                    216,
                    99,
                    73,
                    1,
                  ), // cor da borda ao focar
                ),
              ),
              filled: true,
              fillColor: Color.fromRGBO(196, 108, 68, 0.3),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(
                216,
                99,
                73,
                1,
              ), // controla cor dos ícones e foco também
            ),
          ),
          home: LoginPage(),
        );
      },
    );
  }
}
