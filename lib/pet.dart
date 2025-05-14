class Pet {
  final String nomePet;
  final String nomeDoador;
  final int idade;
  final String especie;
  final List<String> imagens;

  Pet({
    required this.nomePet,
    required this.nomeDoador,
    required this.idade,
    required this.especie,
    required this.imagens,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      nomePet: json['nome'],
      nomeDoador: json['perfil']['usuario']['nome'], 
      idade: json['idade'],
      especie: json['especie'],
      imagens: List<String>.from(json['imagens'] ?? []),
    );
  }
}
