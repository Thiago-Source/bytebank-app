class ContactModel {
  int? id;
  final String nome;
  final int numero;

  ContactModel({required this.nome, required this.numero});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'numero': numero,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(nome: map['nome'], numero: map['numero']);
  }
}
