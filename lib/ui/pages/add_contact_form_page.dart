import 'package:bytebank_app/database/dao/contacts_dao.dart';
import 'package:bytebank_app/models/contact_model.dart';
import 'package:flutter/material.dart';

class AddContactFormPage extends StatelessWidget {
  AddContactFormPage({Key? key}) : super(key: key);

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ContactsDao _contactsDao = ContactsDao();
    return Scaffold(
      appBar: AppBar(
        title: const Text('adicionar contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              decoration: const InputDecoration(
                label: Text('Nome'),
                hintText: 'ex: André',
              ),
            ),
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              decoration: const InputDecoration(
                label: Text('Número da conta'),
                hintText: 'ex: 25004',
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final numeroConta = int.parse(_numeroController.text);
                      final ContactModel newContact = ContactModel(
                          nome: _nomeController.text, numero: numeroConta);
                      _contactsDao.saveContact(newContact).then((_) => Navigator.pop(context));
                    },
                    child: const Text('Criar contato'),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
