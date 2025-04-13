import 'package:adopets/cadastro2_page.dart';
import 'package:estados_municipios/estados_municipios.dart';
import 'package:flutter/material.dart';

class Cadastro1Page extends StatefulWidget {
  const Cadastro1Page({super.key});

  @override
  State<Cadastro1Page> createState() => _Cadastro1PageState();
}

class _Cadastro1PageState extends State<Cadastro1Page> {
  final EstadosMunicipiosController controller = EstadosMunicipiosController();

  List<Estado> estados = [];
  List<Municipio> municipios = [];
  List<String> _dropdownItems = [];

  String? estadoSelecionado;
  String? municipioSelecionado;
  String? siglaEstadoSelecionado;

  String? cep = "";
  String? logradouro = "";
  String? numero = "";
  String? bairro = "";
  String? complemento = "";
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    carregarEstados();
    _dropdownItems = estados.map((estado) => estado.nome).toList();
  }

  Future<void> carregarEstados() async {
    final listaEstados = await controller.buscaTodosEstados();
    setState(() {
      estados = listaEstados;
    });
  }

  Future<void> carregarMunicipios(String sigla) async {
    final listaMunicipios = await controller.buscaMunicipiosPorEstado(sigla);
    setState(() {
      municipios = listaMunicipios;
      municipioSelecionado = null;
    });
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cadastre-se",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(188, 68, 60, 1),
                    fontFamily: "ABeeZee",
                  ),
                ),
                SizedBox(height: 80),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Endereço",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(188, 68, 60, 1),
                      fontFamily: "ABeeZee",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //   SizedBox(
                //   child: Dropdown(
                //     //items: estados.map((estado) => estado.nome).toList(),
                //     //initialSelection: estados.isNotEmpty ? estados.first.nome : null,
                //     items: _dropdownItems,
                //     onChanged: (value){
                //       setState(() {
                //         estadoSelecionado = value;
                //          if (estados.isNotEmpty) {
                //           siglaEstadoSelecionado = estados.firstWhere(
                //             (e) => e.nome == value,
                //             orElse: () => estados.first // Usa o primeiro estado como fallback
                //           ).sigla;
                //         }
                //       });
                //       if(siglaEstadoSelecionado != null){
                //         carregarMunicipios(siglaEstadoSelecionado!);
                //       }
                //     },
                //     key: ValueKey('dropdown_estado_'),
                //   ),

                // ),
                // SizedBox(height: 10),
                //   SizedBox(
                //   child: Dropdown(
                //     items: municipios.map((municipio) => municipio.nome).toList(),
                //     initialSelection: municipios.isNotEmpty ? municipios.first.nome : null,
                //     onChanged: (value){
                //       setState(() {
                //         municipioSelecionado = value;
                //       });
                //     },
                //     key: ValueKey('dropdown_municipio_${municipioSelecionado ?? "null"}'),
                //   ),

                // ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    cep = text;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "CEP"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    logradouro = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Logradouro"),
                ),

                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    numero = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Nº"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    bairro = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Bairro"),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    complemento = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Complemento"),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro2Page()),
                    );
                  },
                  child: Text(
                    "Próximo",
                    style: TextStyle(
                      fontSize: 17,
                      //fontWeight: FontWeight.bold,
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
