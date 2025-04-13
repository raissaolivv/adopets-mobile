import 'package:adopets/adicionar_foto.dart';
import 'package:adopets/barra_navegacao_inferior.dart';
import 'package:adopets/dropdown.dart';
import 'package:flutter/material.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({super.key});

  @override
  State<CadastroPet> createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  String? animal = "";
  String? idade = "";
  String? raca = "";
  String? vacinas = "";
  String? descricao = "";

  String? selectedValue;
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
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  animal = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Animal (Gato, cachorro, etc.)",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  idade = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Idade do pet",
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(
                  items: ["Feminino", "Masculino", "Indefinido"],
                  placeholder: "Sexo",
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  key: ValueKey('dropdown_sexo_${selectedValue ?? "null"}'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Dropdown(
                  items: ["Pequeno", "Médio", "Grande"],
                  placeholder: "Porte",
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  key: ValueKey('dropdown_sexo_${selectedValue ?? "null"}'),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  raca = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Raça",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  vacinas = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Vacinas já aplicadas",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  descricao = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Descrição",
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarExample(),
                    ),
                  );
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
