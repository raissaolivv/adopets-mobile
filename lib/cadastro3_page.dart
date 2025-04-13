import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:flutter/material.dart';

class Cadastro3Page extends StatefulWidget {
  const Cadastro3Page({super.key});

  @override
  State<Cadastro3Page> createState() => _Cadastro3PageState();
}

class _Cadastro3PageState extends State<Cadastro3Page> {
  String? email = "";
  String? senha = "";
  String? confirmacaoSenha = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      "Informações para login",
                      style: TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(188, 68, 60, 1),
                        fontFamily: "ABeeZee"
                      )
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
                    
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text){
                    senha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text){
                    confirmacaoSenha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmação da senha",
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
      )
    );
  }
}