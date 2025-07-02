import 'dart:convert';
import 'dart:io';

import 'package:adopets/adicionar_foto.dart';
import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/dropdown.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({super.key});

  @override
  State<CadastroPet> createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  String? nome = "";
  String? especie = "";
  String? idade = "";
  String? raca = "";
  String? descricao = "";
  bool carregando = false;
  String? sexoSelecionado;
  String? porteSelecionado;
  String? especieSelecionada;
  List<File> imagensSelecionadas = [];

  Future<void> salvarCadastro() async {
    final urlUsuario = Uri.parse('http://192.168.1.237:8080/pets');
    final prefs = await SharedPreferences.getInstance();
    int? usuarioId = prefs.getInt('usuarioId');
    int? perfilId = prefs.getInt('perfilId');


    final responseUsuario = await http.post(
      urlUsuario,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nome": nome,
        "especie": especie!.toUpperCase(),
        "idade": idade,
        "raca": raca,
        "sexo": sexoSelecionado,
        "porte": removeDiacritics(porteSelecionado!.toUpperCase()),
        "descricao": descricao,
        "perfil": {"id": perfilId},
        "usuario": {"id": usuarioId},
        "adotado": false,
      }),
    );

    if (responseUsuario.statusCode == 201) {
      final responseBody = jsonDecode(responseUsuario.body);
      final int petId = responseBody['id'];

      await cadastrarPublicacao(petId, usuarioId, perfilId);
      await enviarImagens(petId);

      print('Cadastro finalizado com sucesso!');
    } else {
      print('Erro ao cadastrar pet: ${responseUsuario.body}');
    }
  }

  Future<void> cadastrarPublicacao(int petId, int? usuarioId, int? perfilId) async {
    final urlPublicacao = Uri.parse('http://192.168.1.237:8080/publicacao');

    final response = await http.post(
      urlPublicacao,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "pet": {"id": petId},
        "perfil": {"id": perfilId},
        "usuario": {"id": usuarioId},
        "descricao": descricao,
        "data_publicacao": DateTime.now().toString().split(' ')[0]
      }),
    );

    if (response.statusCode == 201) {
      print('Publicação criada com sucesso');
    } else {
      print('Erro ao criar publicação: ${response.body}');
    }
  }

  Future<void> enviarImagens(int petId) async {
    final uri = Uri.parse('http://192.168.1.237:8080/pets/$petId/imagens');

    var request = http.MultipartRequest('POST', uri);

    for (var imagem in imagensSelecionadas) {
      request.files.add(
        await http.MultipartFile.fromPath('imagens', imagem.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Imagens enviadas com sucesso");
    } else {
      print("Erro ao enviar imagens: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                "Cadastre um animalzinho",
                style: TextStyle(
                  fontSize: 20,

                  color: Color.fromRGBO(188, 68, 60, 1),
                  fontFamily: "ABeeZee",
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: 350,
                height: 160,
                child: AdicionarFotoPage(
                  descricaoImagem: "Adicione algumas fotos do pet",
                  permiteMultiplasImagens: true,
                  imagensSelecionadas: imagensSelecionadas,
                  onImagensSelecionadas: (novasImagens) {
                    setState(() {
                      imagensSelecionadas = novasImagens;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  nome = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nome do pet"),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(items: ["Gato", "Cachorro", "Pássaro", "Peixe", "Coelho", "Roedor", "Outro"],
                  placeholder: "Animal",
                  onChanged: (value){
                    setState(() {
                      especie = value;
                    });
                  }, 
                  key: ValueKey('dropdown_especie_${especieSelecionada ?? "null"}'),
                ),                
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  idade = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Idade do pet"),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(
                  items: ["Feminino", "Masculino", "Indefinido"],
                  placeholder: "Sexo",
                  onChanged: (value) {
                    setState(() {
                      sexoSelecionado = value;
                    });
                  },
                  key: ValueKey('dropdown_sexo_${sexoSelecionado ?? "null"}'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(
                  items: ["Pequeno", "Médio", "Grande"],
                  placeholder: "Porte",
                  onChanged: (value) {
                    setState(() {
                      porteSelecionado = value;
                    });
                  },
                  key: ValueKey('dropdown_sexo_${porteSelecionado ?? "null"}'),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  raca = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Raça"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  descricao = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Descrição"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    carregando = true;
                  });

                  try {
                    await salvarCadastro();

                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const BottomNavigationBarExample(),
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
                child: Text("Cadastrar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
