import 'contact_model.dart';

class Transaction {
  String? id;
  final double value;
  final ContactModel contact;

  Transaction(
    this.id,
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'contact': {
        'name': contact.nome,
        'accountNumber': contact.numero,
      }
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      map['id'],
      map['value'],
      ContactModel(
        nome: map['contact']['name'],
        numero: map['contact']['accountNumber'],
      ),
    );
  }
}
