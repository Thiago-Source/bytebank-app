import 'contact_model.dart';

class Transaction {
  final double value;
  final ContactModel contact;

  Transaction(
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'contact': {
        'name': contact.nome,
        'accountNumber': contact.numero,
      }
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      map['value'],
      ContactModel(
        nome: map['contact']['name'],
        numero: map['contact']['accountNumber'],
      ),
    );
  }
}
