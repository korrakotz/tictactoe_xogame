
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'history.dart';



class SqlDatabase {
  static final _instance = SqlDatabase._();
  static late Database _database;

  static const String _tableHistory = "historyTable";
  static const String columnid = "id";
  static const String columnPlayerwin = "playerwin";
  static const String columnGametype = "gametype";
  static const String columnDate = "date";


  static const String _createTable = "CREATE TABLE $_tableHistory("
      "$columnid INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$columnPlayerwin TEXT,"
      "$columnGametype TEXT,"
      "$columnDate DATETIME)";

  SqlDatabase._();

  static Future<SqlDatabase> creteInstance() async {
    await initDatabase().then((db) => _database = db);
    return _instance;
  }

  static Future<Database> initDatabase() async {
    /* openDatabase(join(await getDatabasesPath(),"credit_database.db"));
   getDatabasesPath().then((value) => openDatabase(join(value,"credit_database.db")));

    getDatabasesPath().then((value){
      openDatabase(join(value,"credit_database.db"));
    }*/
    return openDatabase(join(await getDatabasesPath(), "history_database.db"),
        version: 1,
        onCreate:
        _onCreate //(db, version) async => await db.execute(_createTable)
    );
  }

  static void _onCreate(Database db, int newVersion) async {
    await db.execute(_createTable);
  }

  Future addHistory(HistoryPlay h) async {
    _database.insert(_tableHistory, h.toMap());
  }

  Future deleteCard(int id) {
    // WHERE id = 0
    return _database.delete(_tableHistory, where: "$columnid = $id");
  }
  Future deleteschema() {
    // WHERE id = 0
    return _database.delete(_tableHistory);
  }

  Future<List<Map<String, Object?>>> getCardById(int id){
    return _database.query(_tableHistory, where: "$columnid = $id");
  }

  /*Future updateCard(CreditCard card) {
    return _database.update(_tableCreditCard, card.toMap(),
        where: "$columnid =${card.id}");
  }*/

  Future<List<HistoryPlay>> getAllHistory() async {
    List<HistoryPlay> list = List<HistoryPlay>.empty(growable: true);
    await _database.query(_tableHistory, orderBy: "$columnDate DESC").then((games) {
      for (var game in games) {
        list.add(HistoryPlay.fromMap(game));
      }
    });
    return list;
  }
  Future<List<HistoryPlay>> get3x3History() async {
    List<HistoryPlay> list = List<HistoryPlay>.empty(growable: true);
    await _database.query(_tableHistory,where: "$columnGametype = '3x3'", orderBy: "$columnDate DESC").then((games) {
      for (var game in games) {
        list.add(HistoryPlay.fromMap(game));
      }
    });
    return list;
  }
  Future<List<HistoryPlay>> get4x4History() async {
    List<HistoryPlay> list = List<HistoryPlay>.empty(growable: true);
    await _database.query(_tableHistory,where: "$columnGametype = '4x4'", orderBy: "$columnDate DESC").then((games) {
      for (var game in games) {
        list.add(HistoryPlay.fromMap(game));
      }
    });
    return list;
  }
  Future<List<HistoryPlay>> get5x5History() async {
    List<HistoryPlay> list = List<HistoryPlay>.empty(growable: true);
    await _database.query(_tableHistory,where: "$columnGametype = '5x5'", orderBy: "$columnDate DESC").then((games) {
      for (var game in games) {
        list.add(HistoryPlay.fromMap(game));
      }
    });
    return list;
  }
  Future<List<HistoryPlay>> get6x6History() async {
    List<HistoryPlay> list = List<HistoryPlay>.empty(growable: true);
    await _database.query(_tableHistory,where: "$columnGametype = '6x6'", orderBy: "$columnDate DESC").then((games) {
      for (var game in games) {
        list.add(HistoryPlay.fromMap(game));
      }
    });
    return list;
  }


 /* Future<List<CreditCard>> getCardsByType(CardType type){
    List<CreditCard> list = List<CreditCard>.empty(growable: true);

    return _database.query(_tableCreditCard,where: "$columnCardType ='${type.name}'").then((cards) => {
      for (var value in cards) {
        list.add(CreditCard.fromMap(value))
      }
    }).then((value) => list);

  }*/
}
