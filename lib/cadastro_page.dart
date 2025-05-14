import 'package:adopets/cadastro1_page.dart';
import 'package:adopets/cadastro_dados.dart';
import 'package:adopets/date_picker.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroDados cadastroDados = CadastroDados();

  String nome = "";
  String sobrenome = "";
  String? selectedValue;
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
                    "Informações pessoais",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(188, 68, 60, 1),
                      fontFamily: "ABeeZee",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    nome = text;
                    //cadastroDados.nome = nome;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    sobrenome = text;
                    //cadastroDados.nome = ("${cadastroDados.nome} $sobrenome");
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Sobrenome",
                  ),
                ),
                SizedBox(height: 10),
                //Campo data de nascimento
                Center(
                  child: DatePickerWidget(
                    onDateSelected: (dataSelecionada) {
                      cadastroDados.dataNasc = dataSelecionada;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: Dropdown(
                    items: [
                      "Feminino",
                      "Masculino",
                      "Transexual",
                      "Não-binário",
                      "Prefiro não responder",
                    ],
                    placeholder: "Sexo",
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                      cadastroDados.sexo = value;
                    },
                    key: ValueKey('dropdown_sexo_${selectedValue ?? "null"}'),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    cadastroDados.nome = "$nome $sobrenome";
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro1Page(cadastroDados: cadastroDados)),
                    );
                  },
                  child: Text(
                    "Próximo",
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
