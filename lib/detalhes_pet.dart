import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetalhesPetPage extends StatefulWidget {
  final int petId;

  const DetalhesPetPage({super.key, required this.petId});

  @override
  State<DetalhesPetPage> createState() => _DetalhesPetPageState();
}

class _DetalhesPetPageState extends State<DetalhesPetPage> {
  Map<String, dynamic>? dadosPet;
  Map<String, dynamic>? dadosDoador;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final petResponse = await http.get(
        Uri.parse('http://192.168.1.237:8080/pets/${widget.petId}'),
      );

      if (petResponse.statusCode == 200) {
        final petData = Map<String, dynamic>.from(jsonDecode(petResponse.body));

        setState(() {
          dadosPet = petData;
        });

        // final prefs = await SharedPreferences.getInstance();
        // final int? usuarioId = prefs.getInt('usuarioId');

        // if (usuarioId != null) {

        final usuarioId = dadosPet!['usuario']['id'];
        final doadorResponse = await http.get(
          Uri.parse('http://192.168.1.237:8080/usuario/$usuarioId'),
        );

        if (doadorResponse.statusCode == 200) {
          final doadorData = Map<String, dynamic>.from(
            jsonDecode(doadorResponse.body),
          );

          setState(() {
            dadosDoador = doadorData;
            loading = false;
          });
        }
        // }
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || dadosPet == null || dadosDoador == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    List<dynamic> imagens = dadosPet!['imagens'] ?? [];

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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Galeria de imagens
            if (imagens.isNotEmpty)
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagens.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Image.network(
                        'http://192.168.1.237:8080${imagens[index]['caminho']}',
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Icon(Icons.broken_image),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),

            Text(
              "Informações adicionais:",
              style: TextStyle(
                fontSize: 22,
                color: Color.fromRGBO(188, 68, 60, 1),
                fontFamily: "ABeeZee",
              ),
            ),

            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(196, 108, 68, 0.5),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome: ${dadosPet!['nome']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Espécie: ${dadosPet!['especie']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Idade: ${dadosPet!['idade']} ano(s)",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Sexo: ${dadosPet!['sexo']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Porte: ${dadosPet!['porte']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Raça: ${dadosPet!['raca']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Descrição: ${dadosPet!['descricao']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 6),

            Text(
              "Informações de contato:",
              style: TextStyle(
                fontSize: 22,
                color: Color.fromRGBO(188, 68, 60, 1),
                fontFamily: "ABeeZee",
              ),
            ),

            SizedBox(height: 6),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(196, 108, 68, 0.5),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome do doador: ${dadosPet!['usuario']['nome']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Telefone do doador: ${dadosPet!['usuario']['telefone']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Email do doador: ${dadosPet!['usuario']['email']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  final telefone =
                      dadosPet!['usuario']['telefone']; // insira aqui o número com DDI e DDD, sem espaços ou traços
                  final mensagem = Uri.encodeComponent(
                    "Olá! Estou interessado(a) no pet ${dadosPet!['nome']}",
                  );
                  final url = Uri.parse(
                    "https://wa.me/$telefone?text=$mensagem",
                  );
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                ),
                label: Text(
                  "Enviar mensagem",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
