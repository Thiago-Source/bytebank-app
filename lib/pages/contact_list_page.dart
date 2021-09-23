import 'package:bytebank_app/database/dao/contacts_dao.dart';
import 'package:bytebank_app/models/contact_model.dart';
import 'package:bytebank_app/pages/add_contact_form_page.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactsDao _contactsDao = ContactsDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: FutureBuilder<List<ContactModel>>(
        initialData: const [],
        future: _contactsDao.queryAllContacts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              final List<ContactModel> contacts = snapshot.data!;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(contacts[index].nome),
                    subtitle: Text(
                      contacts[index].numero.toString(),
                    ),
                  ),
                ),
              );
            default:
              return const Text('sem dados');
          }

          return const Center(
            child: Text('Erro desconhecido'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => AddContactFormPage()),
          ).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
