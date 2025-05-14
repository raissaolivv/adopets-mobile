import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias extends StatefulWidget {
  const Preferencias({super.key});

  @override
  State<Preferencias> createState() => _PreferenciasState();
}

class _PreferenciasState extends State<Preferencias> {
  String? especie = "";
  String? idadeMin = "";
  String? idadeMax = "";
  String? raca = "";
  String? distanciaMax = "";

  bool carregando = false;

  String? sexoSelecionado;
  String? porteSelecionado;
  String? especieSelecionada;

  Future<void> salvarCadastro() async {
    final urlUsuario = Uri.parse('http://192.168.1.237:8080/preferencias');
    final prefs = await SharedPreferences.getInstance();
    int? usuarioId = prefs.getInt('usuarioId');
    int? perfilId = prefs.getInt('perfilId');

    final responseUsuario = await http.post(
      urlUsuario,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "distancia_max": distanciaMax,
        "idade_max": idadeMax,
        "idade_min": idadeMin,
        "raca": raca,
        "sexo": sexoSelecionado,
        "porte":
            porteSelecionado != null
                ? removeDiacritics(porteSelecionado!.toUpperCase())
                : null,

        "especie": especie!.toUpperCase(),
        "perfil": {"id": perfilId},
        "usuario": {"id": usuarioId},
      }),
    );

    if (responseUsuario.statusCode == 201) {
      print('Cadastro finalizado com sucesso!');
    } else {
      print('Erro ao cadastrar preferências: ${responseUsuario.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Cadastre preferências para adotar",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(188, 68, 60, 1),
                  fontFamily: "ABeeZee",
                ),
              ),
              SizedBox(height: 75),
              SizedBox(
                child: Dropdown(
                  items: [
                    "Gato",
                    "Cachorro",
                    "Pássaro",
                    "Peixe",
                    "Coelho",
                    "Roedor",
                    "Outro",
                  ],
                  placeholder: "Animal",
                  onChanged: (value) {
                    setState(() {
                      especie = value;
                    });
                  },
                  key: ValueKey(
                    'dropdown_especie_${especieSelecionada ?? "null"}',
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  idadeMin = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Idade mínima"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  idadeMax = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Idade máxima"),
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
                  distanciaMax = text;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Distância máxima(km)"),
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
