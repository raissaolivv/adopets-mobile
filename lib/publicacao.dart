import 'package:adopets/detalhes_pet.dart';
import 'package:flutter/material.dart';


class Publicacao extends StatelessWidget {
  final String nomeDoador;
  final int idadePet;
  final String especie;
  final List<String> imagens; // URLs ou paths das imagens

  const Publicacao({
    super.key,
    required this.nomeDoador,
    required this.idadePet,
    required this.especie,
    required this.imagens,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.all(10),
      color: Color.fromRGBO(244, 238, 234, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carrossel de imagens
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: imagens.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    imagens[index], 
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
          
          // Informações do pet
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$especie - $idadePet anos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Doador - $nomeDoador",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          // Botões de interação
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/curtir.png",
                  width: 24,
                  height: 24),
                label: Text(
                  "Curtir",
                   style: TextStyle(
                    color: Color.fromRGBO(188, 68, 60, 1),
                  )
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/compartilhar.png",
                  width: 24,
                  height: 24),
                label: Text(
                  "Compartilhar",
                   style: TextStyle(
                    color: Color.fromRGBO(188, 68, 60, 1),
                  )
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesPetPage(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/images/saber_mais.png",
                  width: 24,
                  height: 24),
                label: Text(
                  "Saber mais",
                   style: TextStyle(
                    color: Color.fromRGBO(188, 68, 60, 1),
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}