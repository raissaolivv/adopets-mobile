import 'package:adopets/detalhes_pet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Publicacao extends StatefulWidget {
  final String nomePet;
  final String nomeDoador;
  final int idadePet;
  final String especie;
  final List<String> imagens;
  final String contexto;
  final int publicacaoId;
  final bool adotado;
  final List<int> publicacoesCurtidasIds;

  const Publicacao({
    super.key,
    required this.nomePet,
    required this.nomeDoador,
    required this.idadePet,
    required this.especie,
    required this.imagens,
    required this.contexto,
    required this.publicacaoId,
    required this.adotado,
    required this.publicacoesCurtidasIds,
  });

  @override
  State<Publicacao> createState() => _PublicacaoState();
}

class _PublicacaoState extends State<Publicacao> {
  late bool curtida;

  @override
  void initState() {
    super.initState();
    curtida = widget.publicacoesCurtidasIds.contains(widget.publicacaoId);
  }

  void _curtir() async {
    final prefs = await SharedPreferences.getInstance();
    int? perfilId = prefs.getInt('perfilId');
    if (perfilId == null) return;

    final response = await http.put(
      Uri.parse(
        'http://192.168.1.237:8080/perfil/$perfilId/curtir/${widget.publicacaoId}',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        curtida = true;
      });
    }
  }

  Future<bool> marcarComoAdotado(int petId) async {
    final url = Uri.parse('http://192.168.1.237:8080/pets/$petId/adotar');
    final response = await http.put(url);
    
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Erro ao marcar como adotado: ${response.body}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      color: const Color.fromRGBO(244, 238, 234, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.adotado)
            Container(
              color:  Color.fromRGBO(188, 68, 60, 1),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'ADOTADO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          // Carrossel de imagens
          if (widget.imagens.isNotEmpty)
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: widget.imagens.length,
                itemBuilder: (context, index) {
                  final imagem = widget.imagens[index];

                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child:
                        imagem.startsWith('http')
                            ? Image.network(
                              imagem,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                            )
                            : Image.network(
                              imagem,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                  );
                },
              ),
            ),

          // Informações do pet
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.especie} - ${widget.nomePet} - ${widget.idadePet} anos",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Doador - ${widget.nomeDoador}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),

                _buildBotoes(widget.contexto, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotoes(String contexto, BuildContext context) {
    if (contexto == 'home') {
      return OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: _curtir,
            icon: Image.asset(
              curtida
                  ? "assets/images/curtida.png"
                  : "assets/images/curtir.png",
              width: 24,
              height: 24,
            ),
            label: Text(
              curtida ? "Curtido" : "Curtir",
              style: const TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/compartilhar.png",
              width: 24,
              height: 24,
            ),
            label: const Text(
              "Compartilhar",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetalhesPetPage(petId: widget.publicacaoId),
                ),
              );
            },
            icon: Image.asset(
              "assets/images/saber_mais.png",
              width: 24,
              height: 24,
            ),
            label: const Text(
              "Saber mais",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
        ],
      );
    } else if (contexto == 'minhas_publicacoes') {
      return OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () async {
              bool sucesso = await marcarComoAdotado(
                widget.publicacaoId,
              ); // 👈 passe o ID do pet

              if (sucesso) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pet marcado como adotado!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erro ao marcar como adotado')),
                );
              }
            },
            icon: Icon(
              Icons.pets,
              color: Color.fromRGBO(188, 68, 60, 1),
              size: 24,
            ),
            label: const Text(
              "Adotado!",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Color.fromRGBO(188, 68, 60, 1),
              size: 24,
            ),
            label: const Text(
              "Excluir",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
        ],
      );
    } else if (contexto == 'curtidas') {
      return OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/compartilhar.png",
              width: 24,
              height: 24,
            ),
            label: const Text(
              "Compartilhar",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetalhesPetPage(petId: widget.publicacaoId),
                ),
              );
            },
            icon: Image.asset(
              "assets/images/saber_mais.png",
              width: 24,
              height: 24,
            ),
            label: const Text(
              "Saber mais",
              style: TextStyle(color: Color.fromRGBO(188, 68, 60, 1)),
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
