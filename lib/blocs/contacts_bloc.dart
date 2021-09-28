import 'package:bytebank_app/database/dao/contacts_dao.dart';
import 'package:bytebank_app/models/contact_model.dart';

class ContactsBloc {
  final ContactsDao _contactsDao = ContactsDao();

  void saveContact(ContactModel contact) async {
    await _contactsDao.saveContact(contact);
    return;
  }

  void queryAll() async {
    await _contactsDao.queryAllContacts();
    return;
  }
}
