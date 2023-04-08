import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDataBase {
  Future<Database> getDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table LoginData (ID integer primary key autoincrement,Name text,Email text,Number text,Password text)');
      await db.execute(
          'create table UserData(ID integer primary key autoincrement,Name text,Number text,Userid integer)');
    });
    return database;
  }

  void insertUser(String name, String email, String number, String password,
      Database database) {
    String insert =
        "insert into LoginData (Name,Email,Number,Password) values('$name','$email','$number','$password')";
    database.rawInsert(insert);
  }

  Future<List<Map>> select(
      String loginName, String loginPassword, Database database) async {
    String select =
        "select * from LoginData where Name='$loginName'and Password='$loginPassword'";
    List<Map> selectList = await database.rawQuery(select);
    return selectList;
  }

  Future<void> insertContact(
      String insertName, String insertNumber, int id, Database database) async {
    String insertUserContact =
        "insert into UserData (Name,Number,Userid) values('$insertName','$insertNumber','$id')";
    int insert = await database.rawInsert(insertUserContact);
  }

  Future<List<Map>> viewContact(int? id, Database database) async {
    String view = "select * from UserData where Userid='$id'";
    List<Map> viewList = await database.rawQuery(view);
    return viewList;
  }

  Future<void> delteContact(userContactList, Database database) async {
    String delete = "delete from UserData where ID='$userContactList'";
    int deletedContact = await database.rawDelete(delete);
  }

  Future<void> updateUserContact(
      Database database, String name, String number, userContactList) async {
    String update =
        "update UserData set Name='$name',Number='$number' where ID='$userContactList'";
    int updated = await database.rawUpdate(update);
  }
}
