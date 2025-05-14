import 'package:adopets/cadastro_pet.dart';
import 'package:adopets/home_page.dart';
import 'package:adopets/meu_perfil.dart';
import 'package:adopets/preferencias.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CadastroPet(),
    Preferencias(),
    MeuPerfil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        elevation: 4.0,
        backgroundColor: Color.fromRGBO(218, 196, 176, 1.0),
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Text("Adopets"),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              width: 24,
              height: 24),
            label: 'Home',
            backgroundColor: Color.fromRGBO(218, 196, 176, 1),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/cadastrar_pet.png",
              width: 24,
              height: 24),
            label: 'Cadastre um pet',
            backgroundColor:Color.fromRGBO(218, 196, 176, 1),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/preferencias.png",
              width: 24,
              height: 24),
            label: 'Preferências',
            backgroundColor: Color.fromRGBO(218, 196, 176, 1),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/meu_perfil.png",
              width: 24,
              height: 24),
            label: 'Meu perfil',
            backgroundColor:Color.fromRGBO(218, 196, 176, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(121, 29, 22, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}