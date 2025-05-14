import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdicionarFotoPage extends StatefulWidget {
  final String descricaoImagem;
  final bool permiteMultiplasImagens;  
  final List<File> imagensSelecionadas;
  final Function(List<File>) onImagensSelecionadas;

  const AdicionarFotoPage({
    super.key, 
    required this.descricaoImagem,
    required this.permiteMultiplasImagens,    
    required this.imagensSelecionadas,
    required this.onImagensSelecionadas,
  });

  @override
  _AdicionarFotoPageState createState() => _AdicionarFotoPageState();
}

class _AdicionarFotoPageState extends State<AdicionarFotoPage> {
  List<File> _imagensSelecionadas = [];

  Future<void> _selecionarImagem(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: source);

    if (imagem != null) {
      setState(() {
        if (widget.permiteMultiplasImagens) {
          _imagensSelecionadas.add(File(imagem.path));
        } else {
          _imagensSelecionadas = [File(imagem.path)];
        }
        widget.onImagensSelecionadas(_imagensSelecionadas);       
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imagensSelecionadas.isNotEmpty
              ? _imagensSelecionadas.map((img) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(img),
                  );
                }).toList()
              : [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                ],
        ),
        SizedBox(height: 10),
        Text(
          widget.descricaoImagem,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "ABeeZee",
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _selecionarImagem(ImageSource.gallery),
              icon: Icon(Icons.image, color: Colors.white),
              label: Text("Galeria", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _selecionarImagem(ImageSource.camera),
              icon: Icon(Icons.camera, color: Colors.white),
              label: Text("Câmera", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(216, 99, 73, 0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
