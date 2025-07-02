import 'dart:convert';

import 'package:adopets/cadastro_dados.dart';
import 'package:adopets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cadastro3Page extends StatefulWidget {
  final CadastroDados cadastroDados;
  const Cadastro3Page({super.key, required this.cadastroDados});

  @override
  State<Cadastro3Page> createState() => _Cadastro3PageState();
}

class _Cadastro3PageState extends State<Cadastro3Page> {
  String? login = "";
  String? senha = "";
  String? confirmacaoSenha = "";
  bool carregando = false;

  Future<void> salvarCadastro(CadastroDados cadastroDados) async {
    final urlUsuario = Uri.parse('http://192.168.1.237:8080/usuario');

    final responseUsuario = await http.post(
      urlUsuario,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cadastroDados.toJsonUsuario()),
    );

    if (responseUsuario.statusCode == 201) {
      final data = jsonDecode(responseUsuario.body);
      cadastroDados.usuarioId = data['id'];

      final urlPerfil = Uri.parse('http://192.168.1.237:8080/perfil');
      final responsePerfil = await http.post(
        urlPerfil,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(cadastroDados.toJsonPerfil()),
      );

      if (responsePerfil.statusCode == 201) {
        print('Cadastro finalizado com sucesso!');
      } else {
        print('Erro ao cadastrar perfil: ${responsePerfil.body}');
      }
    } else {
      print('Erro ao cadastrar usuário: ${responseUsuario.body}');
    }
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
                    fontFamily: "ABeeZee",
                  ),
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
                      fontFamily: "ABeeZee",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    login = text;
                    widget.cadastroDados.login = login;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Login"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    senha = text;
                    widget.cadastroDados.senha = senha;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Senha"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    confirmacaoSenha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmação da senha",
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if (senha != confirmacaoSenha) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("As senhas não coincidem!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    setState(() {
                      carregando = true;
                    });

                    try {
                      await salvarCadastro(widget.cadastroDados);

                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const LoginPage(),
                          ),
                        );
                      }
                    } catch (e, stacktrace) {
                      print("Erro no cadastro: $e");
                      print(stacktrace);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Erro ao cadastrar. Tente novamente."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } finally {
                      setState(() {
                        carregando = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                  ),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white),
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
