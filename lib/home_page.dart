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
  bool carregando = true;
  String? especieSelecionada = "Todas";
  String? statusAdocaoSelecionado = "Todos";

  List<int> publicacoesCurtidasIds = [];
  List<Widget> publicacoes = [];
  List<dynamic> publicacoesFiltradas = [];
  List<dynamic> todasPublicacoes = [];
  List<String> especies = [
    "Todas",
    "Gato",
    "Cachorro",
    "Pássaro",
    "Peixe",
    "Coelho",
    "Roedor",
    "Outro",
  ];
  List<String> statusAdocao = ["Todos", "Disponível", "Adotado"];

  List<dynamic> petsData = [];
  List<dynamic> pubsData = [];

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
      petsData = jsonDecode(responsePets.body);
      pubsData = jsonDecode(responsePublicacoes.body);

      int cont = 0;

      for (var pet in pets) {
        final publicacao = listaPublicacoes[cont];
        int publicacaoId = publicacao['id'];
        int petId = pet['id'];
        String nomePet = pet['nome'];
        String nomeDoador = pet['usuario']['nome'] ?? "Desconhecido";
        int idade = pet['idade'];
        String especie = pet['especie'];
        bool adotado = pet['adotado'];

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
            publicacoesCurtidasIds: publicacoesCurtidasIds,
            adotado: adotado
          ),
        );
        cont++;
      }

      setState(() {
        publicacoes = listaWidgets;
        carregando = false;
        todasPublicacoes = pubsData;
        aplicarFiltro();
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
      'http://192.168.1.237:8080/pets/$petId/imagens',
    );
    final response = await http.get(urlImagens);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((e) {
        final caminho = e['caminho'].toString();
        return 'http://192.168.1.237:8080$caminho';
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> aplicarFiltro() async {
    // filtra petsData
    final filteredPets =
        petsData.where((pet) {
          final petEspecie = pet['especie']?.toString().toLowerCase();
          final filtroEspecie = especieSelecionada?.toLowerCase();

          final okEspecie =
              especieSelecionada == "Todas" ||
              petEspecie == filtroEspecie;
          // certifique-se de que seu JSON de pet tem 'adotado': true/false
          final okStatus =
              statusAdocaoSelecionado == "Todos" ||
              (statusAdocaoSelecionado == 'Adotado' &&
                  pet['adotado'] == true) ||
              (statusAdocaoSelecionado == 'Disponível' &&
                  pet['adotado'] == false);
          return okEspecie && okStatus;
        }).toList();

    // monta cada widget Publicacao
    List<Widget> novaLista = [];
    for (var pet in filteredPets) {
      final pub = pubsData.firstWhere(
        (p) => p['pet']['id'] == pet['id'],
        orElse: () => null,
      );
      if (pub == null) continue;

      final imagens = await buscarImagensDoPet(pet['id']);
      novaLista.add(
        Publicacao(
          publicacaoId: pub['id'],
          nomePet: pet['nome'],
          nomeDoador: pet['usuario']['nome'] ?? 'Desconhecido',
          idadePet: pet['idade'],
          especie: pet['especie'],
          adotado: pet['adotado'],
          imagens: imagens,
          contexto: 'home',
          publicacoesCurtidasIds: publicacoesCurtidasIds,
        ),
      );
    }

    // atualiza tudo de uma vez
    setState(() {
      publicacoes = novaLista;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Column(
        children: [
          // filtros
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    value: especieSelecionada,
                    decoration: const InputDecoration(
                      labelText: 'Espécie',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      )),
                    items:
                        especies
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (v) {
                      setState(() => especieSelecionada = v);
                      aplicarFiltro();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    value: statusAdocaoSelecionado,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      )),
                    items:
                        statusAdocao
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (v) {
                      setState(() => statusAdocaoSelecionado = v);
                      aplicarFiltro();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 3),
          // lista de Publicacao
          Expanded(child: ListView(children: publicacoes)),
        ],
      ),
    );
  }
}
