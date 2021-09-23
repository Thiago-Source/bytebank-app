import 'package:bytebank_app/models/contact_model.dart';
import '../app_database.dart';
import 'package:sqflite/sqflite.dart';

class ContactsDao {
  final AppDatabase _appDatabase = AppDatabase();
  static const String _tableName = 'contacts';
  static const String _idColumn = 'id';
  static const String _nomeColumn = 'nome';
  static const String _numeroColumn = 'numero';
  static const String createDatabase = '''CREATE TABLE $_tableName(
           $_idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
           $_nomeColumn TEXT NOT NULL,
           $_numeroColumn INTEGER NOT NULL
         )''';

  Future<int> saveContact(ContactModel contact) async {
    final Database db = await _appDatabase.createDatabase();
    return db.insert(
      _tableName,
      contact.toMap(),
    );
  }

  Future<List<ContactModel>> queryAllContacts() async {
    final Database db = await _appDatabase.createDatabase();
    final List<Map<String, Object?>> result = await db.query(_tableName);
    final List<ContactModel> contactList = [];
    for (Map<String, dynamic> contact in result) {
      final newContact = ContactModel.fromMap(contact);
      contactList.add(newContact);
    }

    return contactList;
  }
}
