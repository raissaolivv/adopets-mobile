import 'package:adopets/adicionar_foto.dart';
import 'package:adopets/cadastro3_page.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';

class Cadastro2Page extends StatefulWidget {
  const Cadastro2Page({super.key});

  @override
  State<Cadastro2Page> createState() => _Cadastro2PageState();
}

class _Cadastro2PageState extends State<Cadastro2Page> {
  String? email = "";
  String? telefone = "";
  String? selectedValue; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Color.fromRGBO(218, 196, 176, 1.0),
        centerTitle: true,        
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cadastre-se",
                  style: TextStyle(
                    fontSize: 22,
                    //fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(188, 68, 60, 1),
                    fontFamily: "ABeeZee"
                  )
                  ),
                  SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Informações adicionais",
                      style: TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(188, 68, 60, 1),
                        fontFamily: "ABeeZee"
                      )
                      ),
                  ),                     
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350, 
                    height: 120, 
                    child: AdicionarFotoPage("Adicione uma foto de perfil"),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                  child: Dropdown(items: ["Casa", "Apartamento", "Kitnet", "Campo", "Outro"],
                                  initialSelection: "Casa", 
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
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
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
                    telefone = text;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefone",
                    filled: true,
                    border:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                    
                  ),
                ),                
                SizedBox(height: 50),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => Cadastro3Page()),
                      );
                  },                    
                  child: Text(
                    "Próximo",
                    style: TextStyle(
                      fontSize: 17,
                      //fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(188, 68, 60, 1),
                      fontFamily: "ABeeZee",
                      decoration: TextDecoration.underline,
                       decorationColor: Color.fromRGBO(188, 68, 60, 1),
                    )
                  ),
                )
              ],
            )
          )
        )
      )
    );
  }
}