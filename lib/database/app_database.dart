import 'package:bytebank_app/database/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> createDatabase() async {
    final String path = join(await getDatabasesPath(), 'bytebank.db');
    return await openDatabase(path, onCreate: (db, version) {
      db.execute(ContactsDao.createDatabase);
    }, version: 1);
  }

}
