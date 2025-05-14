import 'dart:io';

class AdicionarFotoController {
  List<File> imagensSelecionadas = [];

  void adicionarImagem(File imagem, {bool multipla = true}) {
    if (multipla) {
      imagensSelecionadas.add(imagem);
    } else {
      imagensSelecionadas = [imagem];
    }
  }

  void limparImagens() {
    imagensSelecionadas.clear();
  }
}
