import 'package:adopets/cadastro3_page.dart';
import 'package:adopets/cadastro_dados.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';

class Cadastro2Page extends StatefulWidget {
  final CadastroDados cadastroDados;
  const Cadastro2Page({super.key, required this.cadastroDados});

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
            Text("Adota Um"),
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
                  // SizedBox(
                  //   width: 350, 
                  //   height: 160, 
                  //   child: AdicionarFotoPage(descricaoImagem: "Adicione uma foto de perfil", permiteMultiplasImagens: false),
                  // ),
                  SizedBox(height: 10),
                  SizedBox(
                  child: Dropdown(items: ["Casa", "Apartamento", "Kitnet", "Campo", "Outro"],
                                  placeholder: "Tipo de moradia",
                                  onChanged: (value){
                                    setState(() {
                                      selectedValue = value;
                                    });
                                    widget.cadastroDados.tipoMoradia =  selectedValue;
                                  }, 
                                  key: ValueKey('dropdown_moradia_${selectedValue ?? "null"}'),
                        ),
                  
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text){
                    email = text;
                    widget.cadastroDados.email = email;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",                    
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text){
                    telefone = text;
                    widget.cadastroDados.telefone = telefone;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefone",                    
                  ),
                ),                
                SizedBox(height: 50),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => Cadastro3Page(cadastroDados: widget.cadastroDados)),
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