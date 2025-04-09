import 'package:adopets/publicacao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Publicacao(
          nomeDoador: "Ana Souzae",
          idadePet: 2,
          especie: "Cachorro",
          imagens: ["assets/images/dog1.jpg", "assets/images/dog2.jpg", "assets/images/dog3.jpg"],
        ),
        Publicacao(
          nomeDoador: "Carlos Mendes",
          idadePet: 3,
          especie: "Cachorro",
          imagens: ["assets/images/dog1.jpg", "assets/images/dog2.jpg", "assets/images/dog3.jpg"],
        ),
        // Publicacao(
        //   nomeDoador: "João Silva",
        //   idadePet: 2,
        //   especie: "Cachorro",
        //   imagens: ["assets/images/dog1.jpg", "assets/images/dog2.jpg", "assets/images/dog3.jpg"],
        // ),
      ],
    );
  }
}