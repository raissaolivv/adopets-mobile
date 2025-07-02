import 'dart:convert';

import 'package:adopets/login_page.dart';
import 'package:adopets/publicacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MeuPerfil extends StatefulWidget {
  const MeuPerfil({super.key});

  @override
  State<MeuPerfil> createState() => _MeuPerfilState();
}

class _MeuPerfilState extends State<MeuPerfil> {
  bool mostrarCurtidas = false;
  bool mostrarMinhas = true;
  List<dynamic> minhasPublicacoes = [];
  List<dynamic> publicacoesCurtidas = [];
  List<int> publicacoesCurtidasIds = [];
  String? nomeUsuario;

  @override
  void initState() {
    super.initState();
    carregarPublicacoes();
    carregarCurtidas();
    carregarNomeUsuario();
  }

  Future<void> carregarPublicacoes() async {
    final prefs = await SharedPreferences.getInstance();
    final perfilId = prefs.getInt('perfilId');

    if (perfilId == null) return;

    final responseMeusPets = await http.get(
      Uri.parse(
        'http://192.168.1.237:8080/perfil/$perfilId/animaisCadastrados',
      ),
    );

    final responseCurtidas = await http.get(
      Uri.parse('http://192.168.1.237:8080/perfil/$perfilId/curtidas'),
    );

    if (responseMeusPets.statusCode == 200 &&
        responseCurtidas.statusCode == 200) {
      setState(() {
        minhasPublicacoes = List.from(jsonDecode(responseMeusPets.body));
        publicacoesCurtidas = List.from(jsonDecode(responseCurtidas.body));
      });
    }
  }

  Future<void> carregarCurtidas() async {
    final prefs = await SharedPreferences.getInstance();
    int? perfilId = prefs.getInt('perfilId');

    if (perfilId == null) return;

    final response = await http.get(
      Uri.parse('http://192.168.1.237:8080/perfil/$perfilId/curtidas'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> curtidasJson = jsonDecode(response.body);
      setState(() {
        publicacoesCurtidasIds =
            curtidasJson.map((p) => p['id'] as int).toList();
      });
    }
  }

  Future<void> carregarNomeUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
              ),
              SizedBox(height: 10),
              Text(
                "$nomeUsuario",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              /// MINHAS PUBLICAÇÕES
              ExpansionTile(
                title: Text("Minhas publicações"),
                children:
                    minhasPublicacoes.map((pub) {
                      return Publicacao(
                        publicacaoId: pub['id'],
                        nomeDoador: "$nomeUsuario",
                        nomePet: pub['nome'],
                        idadePet: pub['idade'],
                        especie: pub['especie'],
                        adotado: pub['adotado'],
                        imagens:
                            (pub['imagens'] as List<dynamic>)
                                .map((img) => "http://192.168.1.237:8080${img['caminho']}")
                                .toList(),
                        contexto: "minhas_publicacoes",
                        publicacoesCurtidasIds: publicacoesCurtidasIds,
                      );
                    }).toList(),
              ),
              ExpansionTile(
                title: Text("Publicações curtidas"),
                children:
                    publicacoesCurtidas.map((pub) {
                      return Publicacao(
                        publicacaoId: pub['id'],
                        nomeDoador: pub['usuario']['nome'],
                        nomePet: pub['pet']['nome'],
                        idadePet: pub['pet']['idade'],
                        especie: pub['pet']['especie'],
                        adotado: pub['pet']['adotado'],
                        imagens:
                            (pub['pet']['imagens'] as List<dynamic>)
                                .map((img) => "http://192.168.1.237:8080${img['caminho']}")
                                .toList(),
                        contexto: "curtidas",
                        publicacoesCurtidasIds: publicacoesCurtidasIds,
                      );
                    }).toList(),
              ),

              SizedBox(height: 20),

              /// BOTÕES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                    ),
                    child: Text('Sair', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getInt('usuarioId');
                      final perfilId = prefs.getInt('perfilId');

                      if (userId == null || perfilId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erro ao recuperar dados do usuário.',
                            ),
                          ),
                        );
                        return;
                      }

                      try {
                        await http.delete(
                          Uri.parse(
                            'http://192.168.1.237:8080/usuario/$userId/excluirTudo',
                          ),
                          headers: {'Content-Type': 'application/json'},
                        );

                        // Limpar sessão
                        await prefs.clear();

                        // Redirecionar para login
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                          (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erro ao excluir conta: ${e.toString()}',
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                    ),
                    child: Text(
                      'Excluir Conta',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
