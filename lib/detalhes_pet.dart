import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetalhesPetPage extends StatelessWidget {
  //final Map<String, dynamic> dados;

  Map<String, dynamic> dados = {
    'nome': 'Luna',
    'especie': 'Cachorro',
    'idade': 2,
    'sexo': 'Fêmea',
    'porte': 'Pequeno',
    'descricao':
        'Muito dócil e sociável. Adora brincar com crianças e outros animais.',
    'imagens': [
      'assets/images/dog1.jpg',
      'assets/images/dog2.jpg',
      'assets/images/dog3.jpg',
    ],
  };

  //const DetalhesPetPage({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    List<dynamic> imagens = dados['imagens'];

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
                      child: Image.asset(
                        imagens[index],
                        width: 200,
                        fit: BoxFit.cover,
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
                    "Nome: ${dados['nome']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Espécie: ${dados['especie']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Idade: ${dados['idade']} ano(s)",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Sexo: ${dados['sexo']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Porte: ${dados['porte']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Raça: ${dados['raça']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Vacinas já aplicadas: ${dados['vacinas']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Descrição: ${dados['descricao']}",
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
                    "Nome do doador: ${dados['nome_doador']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Telefone do doador: ${dados['telefone_doador']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 236, 221, 221),
                    ),
                  ),
                  Text(
                    "Email do doador: ${dados['email_doador']}",
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
              child:
                ElevatedButton.icon(
                  onPressed: () {
                    final telefone =
                        "5535999169555"; // insira aqui o número com DDI e DDD, sem espaços ou traços
                    final mensagem = Uri.encodeComponent(
                      "Olá! Estou interessado(a) no pet ${dados['nome']}",
                    );
                    final url = Uri.parse("https://wa.me/$telefone?text=$mensagem");
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                  ),
                  label: Text("Enviar mensagem", style: TextStyle(color: Colors.white)),
                )
            ),
          ],
        ),
      ),
    );
  }
}
