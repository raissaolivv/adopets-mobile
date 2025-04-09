import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';

class Preferencias extends StatefulWidget {
  const Preferencias({super.key});

  @override
  State<Preferencias> createState() => _PreferenciasState();
}

class _PreferenciasState extends State<Preferencias> {
  String? animal = "";
  String? idadeMin = "";  
  String? idadeMax = "";
  String? raca = "";
  String? distanciaMax = "";

  String? selectedValue; 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Cadastre preferências para adotar",
                style: TextStyle(
                  fontSize: 20,                  
                  color: Color.fromRGBO(188, 68, 60, 1),
                  fontFamily: "ABeeZee"
                )
              ),    
              SizedBox(height: 75),  
              TextField(
                onChanged: (text){
                  animal = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Animal (Gato, cachorro, etc.)",
                  filled: true,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromRGBO(196, 108, 68, 0.3),                    
                ),
              ),  
              SizedBox(height: 10),
              TextField(
                onChanged: (text){
                  idadeMin = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Idade mínima",
                  filled: true,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                  
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text){
                  idadeMax = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Idade máxima",
                  filled: true,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                  
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(items: ["Feminino", "Masculino", "Indefinido"],
                  initialSelection: "Indefinido", 
                  onChanged: (value){
                    setState(() {
                      selectedValue = value;
                    });
                  }, 
                  key: ValueKey('dropdown_sexo_${selectedValue ?? "null"}'),
                ),                
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(items: ["Pequeno", "Médio", "Grande"],
                  initialSelection: "Pequeno", 
                  onChanged: (value){
                    setState(() {
                      selectedValue = value;
                    });
                  }, 
                  key: ValueKey('dropdown_sexo_${selectedValue ?? "null"}'),
                ),                
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text){
                  raca = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Raça",
                  filled: true,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                  
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text){
                  distanciaMax = text;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Distância máxima(km)",
                  filled: true,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                  
                ),
              ),  
              SizedBox(height: 15),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const BottomNavigationBarExample()),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7)
                  ),
                  child: Text(
                    "Cadastrar",
                     style: TextStyle(
                        color: Colors.white
                    )
                  )
                ),          
            ],
          )
        )
      )
    );
  }
}