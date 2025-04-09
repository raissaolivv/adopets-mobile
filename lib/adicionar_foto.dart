import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdicionarFotoPage extends StatefulWidget {
  final String descricaoImagem;

  const AdicionarFotoPage(this.descricaoImagem);

  @override
  _AdicionarFotoPageState createState() => _AdicionarFotoPageState();
}

class _AdicionarFotoPageState extends State<AdicionarFotoPage> {
  File? _imagemSelecionada;

  Future<void> _selecionarImagem(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: source);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imagemSelecionada != null
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(_imagemSelecionada!),                
                )
              : CircleAvatar(
                  radius: 30,
                  backgroundColor:Color.fromRGBO(216, 99, 73, 0.7),
                  child: Icon(
                    Icons.person, 
                    size: 30,
                    color:  Colors.white),
                ),
          SizedBox(width: 10),     
          Text(
            widget.descricaoImagem,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: "ABeeZee"
            )
          ) 
        ]     
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () => _selecionarImagem(ImageSource.gallery),
            icon: Icon(
              Icons.image,
              color: Colors.white
            ),
            label: Text(
              "Escolher da Galeria",
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255)
              )),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
              backgroundColor: Color.fromRGBO(216, 99, 73, 0.7)
            ),
          ),
          SizedBox(width: 10), 
          ElevatedButton.icon(
            onPressed: () => _selecionarImagem(ImageSource.camera),
            icon: Icon(
              Icons.camera,
              color: Colors.white),
            label: Text(
              "Tirar Foto", 
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255)
              )
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
              backgroundColor: Color.fromRGBO(216, 99, 73, 0.7)
            ),
          ),
        ]
      )        
      ],
    );
  }
}
