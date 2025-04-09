import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/cadastro_page.dart';
import 'package:adopets/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
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
              children: [
                Text(
                  "Bem-vindo de volta!",
                  style: TextStyle(
                    fontSize: 22,
                    //fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(188, 68, 60, 1),
                    fontFamily: "ABeeZee"
                  )
                  ),
                SizedBox(height: 80),
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
                    senha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    filled: true,
                    fillColor: Color.fromRGBO(196, 108, 68, 0.3),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: (){
                    if(email == "teste@email.com" && senha == "123"){
                      print("correto");
                    }else{
                      print("incorreto");
                    }
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const BottomNavigationBarExample()),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7)
                  ),
                  child: Text(
                    "Entrar",
                     style: TextStyle(
                        color: Colors.white
                    )
                  )
                ),
                SizedBox(height: 55),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                      );
                  },                    
                  child: Text(
                    "Cadastre-se aqui",
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