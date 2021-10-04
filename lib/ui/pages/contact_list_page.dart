import 'package:bytebank_app/blocs/container/container.dart';
import 'package:bytebank_app/database/dao/contacts_dao.dart';
import 'package:bytebank_app/models/contact_model.dart';
import 'package:bytebank_app/ui/pages/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_contact_form_page.dart';

abstract class ContactListState {
  const ContactListState();
}

class LoadingState extends ContactListState {
  const LoadingState();
}

class LoadedState extends ContactListState {
  final List<ContactModel> _contactsList;
  const LoadedState(this._contactsList);
}

class ErrorState extends ContactListState {
  final String message;
  const ErrorState(this.message);
}

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(const LoadingState());

  void reload(ContactsDao dao) async {
    emit(const LoadingState());
    List<ContactModel> _contactsList = await dao.queryAllContacts();
    emit(LoadedState(_contactsList));
  }
}

class ContactListContainer extends BlocContainer {
  final ContactsDao _contactsDao = ContactsDao();

  ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListCubit>(
      create: (BuildContext context) {
        final cubit = ContactListCubit();
        cubit.reload(_contactsDao);
        return cubit;
      },
      child: ContactList(_contactsDao),
    );
  }
}

class ContactList extends StatelessWidget {
  final ContactsDao _contactsDao;
  const ContactList(this._contactsDao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is LoadedState) {
            final List<ContactModel> contacts = state._contactsList;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () {
                    push(context, TransactionFormContainer(contacts[index]));
                  },
                  title: Text(contacts[index].nome),
                  subtitle: Text(
                    contacts[index].numero.toString(),
                  ),
                ),
              ),
            );
          }

          return const Center(
            child: Text('Erro desconhecido'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddContactFormPage()),
          );

          context.read<ContactListCubit>().reload(_contactsDao);
        },
      ),
    );
  }
}
