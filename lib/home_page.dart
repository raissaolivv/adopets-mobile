import 'dart:convert';
import 'package:adopets/publicacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> publicacoes = [];
  bool carregando = true;
  List<int> publicacoesCurtidasIds = [];

  @override
  void initState() {
    super.initState();
    carregarPublicacoes();
    carregarCurtidas();
  }

  Future<void> carregarPublicacoes() async {
    final urlPets = Uri.parse('http://192.168.1.237:8080/pets');
    final urlPublicacoes = Uri.parse('http://192.168.1.237:8080/publicacao');
    final responsePets = await http.get(urlPets);
    final responsePublicacoes = await http.get(urlPublicacoes);

    if (responsePets.statusCode == 200) {
      final List<dynamic> pets = jsonDecode(responsePets.body);

      List<dynamic> listaPublicacoes = jsonDecode(responsePublicacoes.body);
      List<Widget> listaWidgets = [];

      int cont = 0;

      for (var pet in pets) {
        final publicacao = listaPublicacoes[cont];
        int publicacaoId = publicacao['id'];
        int petId = pet['id'];
        String nomePet = pet['nome'];
        String nomeDoador = pet['usuario']['nome'] ?? "Desconhecido";
        int idade = pet['idade'];
        String especie = pet['especie'];

        List<String> imagens = await buscarImagensDoPet(petId);

        listaWidgets.add(
          Publicacao(
            publicacaoId: publicacaoId,
            nomePet: nomePet,
            nomeDoador: nomeDoador,
            idadePet: idade,
            especie: especie,
            imagens: imagens,
            contexto: "home",
            publicacoesCurtidasIds: publicacoesCurtidasIds
          ),
        );
        cont++;
      }

      setState(() {
        publicacoes = listaWidgets;
        carregando = false;
      });
    } else {
      print("Erro ao buscar pets: ${responsePets.body}");
      setState(() {
        carregando = false;
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

  Future<List<String>> buscarImagensDoPet(int petId) async {
    final urlImagens = Uri.parse(
      'http://192.168.1.237:8080/pet/imagens/$petId',
    );
    final response = await http.get(urlImagens);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e['caminho'].toString()).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return carregando
        ? const Center(child: CircularProgressIndicator())
        : ListView(children: publicacoes);
  }
}
