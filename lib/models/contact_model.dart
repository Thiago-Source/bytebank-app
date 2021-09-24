class ContactModel {
  int? id;
  final String nome;
  final int numero;

  ContactModel({required this.nome, required this.numero, this.id});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'numero': numero,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
        id: map['id'], nome: map['nome'], numero: map['numero']);
  }
}
