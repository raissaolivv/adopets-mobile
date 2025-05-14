// import 'dart:convert';

// import 'package:adopets/pet.dart';
// import 'package:adopets/publicacao.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TelaPublicacoes extends StatefulWidget {
//   @override
//   _TelaPublicacoesState createState() => _TelaPublicacoesState();
// }

// class _TelaPublicacoesState extends State<TelaPublicacoes> {
//   List<Pet> pets = [];

//   @override
//   void initState() {
//     super.initState();
//     buscarPets();
//   }

//   Future<void> buscarPets() async {
//     final response = await http.get(Uri.parse('http://SEU_IP:8080/pets'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       setState(() {
//         pets = jsonData.map((e) => Pet.fromJson(e)).toList();
//       });
//     } else {
//       print('Erro ao buscar pets');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: pets.length,
//       itemBuilder: (context, index) {
//         final pet = pets[index];
//         return Publicacao(
//           nomeDoador: pet.nomeDoador,
//           idadePet: pet.idade,
//           especie: pet.especie,
//           //imagens: pet.imagens,
//         );
//       },
//     );
//   }
// }
