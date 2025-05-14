import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login = "";
  String senha = "";

  Future<void> fazerLogin(String login, String senha) async {
    final url = Uri.parse('http://192.168.1.237:8080/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"login": login, "senha": senha}),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        int usuarioId = json['id'];
        int perfilId = json['perfil']['id'];
        String usuario = json['nome'];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setInt('usuarioId', usuarioId);
        await prefs.setInt('perfilId', perfilId);
        prefs.setString('nomeUsuario', usuario);

        print('Login bem-sucedido! Usuário: ${json['nome']}');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarExample()),
          
        
        );
      } else {
        print('Erro no login: ${response.body}');
        mostrarErro("Login ou senha inválidos!");
      }
    } catch (e) {
      print('Erro de conexão: $e');
      mostrarErro("Erro de conexão com o servidor");
    }
  }

  void mostrarErro(String mensagem) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Erro'),
            content: Text(mensagem),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Color.fromRGBO(218, 196, 176, 1.0),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 30, height: 30),
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
                    fontFamily: "ABeeZee",
                  ),
                ),
                SizedBox(height: 80),
                TextField(
                  onChanged: (text) {
                    login = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Login"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Senha"),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    await fazerLogin(login, senha);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                  ),
                  child: Text("Entrar", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 55),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  child: Text(
                    "Cadastre-se aqui",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(188, 68, 60, 1),
                      fontFamily: "ABeeZee",
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromRGBO(188, 68, 60, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
