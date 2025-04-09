import 'package:adopets/publicacao.dart';
import 'package:flutter/material.dart';

class MeuPerfil extends StatefulWidget {
  const MeuPerfil({super.key});

  @override
  State<MeuPerfil> createState() => _MeuPerfilState();
}

class _MeuPerfilState extends State<MeuPerfil> {
   bool mostrarCurtidas = false;
  bool mostrarMinhas = true;

  void _logout() {
    // lógica de sair da conta
  }

  void _excluirConta() {
    // lógica para excluir a conta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/dog1.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                'Nome do Usuário',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              /// MINHAS PUBLICAÇÕES
              ExpansionTile(
                title: Text("Minhas publicações"),
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
                ],
              ),

              /// PUBLICAÇÕES CURTIDAS
              ExpansionTile(
                title: Text("Publicações curtidas"),
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
                ],
              ),

              SizedBox(height: 20),

              /// BOTÕES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromRGBO(216, 99, 73, 0.7)
                    ),
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromRGBO(216, 99, 73, 0.7)
                    ),
                    child: Text(
                      'Excluir Conta',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}