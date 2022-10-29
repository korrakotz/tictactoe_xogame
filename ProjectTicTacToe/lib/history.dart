
import 'database.dart';


class HistoryPlay {
  int id;
  String playerwin;
  String gametype;
  DateTime date;


  HistoryPlay(
      {this.id = 0,
        required this.playerwin,
        required this.gametype,
        required this.date});

  Map<String, dynamic> toMap() {
    return {
      'playerwin': playerwin,
      'gametype': gametype,
      'date': date.toString(),

    };
  }

  static HistoryPlay fromMap(Map map) {
    // Map<String,String> หมายถึง Map<key,value>
    //map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id
    return HistoryPlay(
        id: map[SqlDatabase.columnid],
        playerwin: map[SqlDatabase.columnPlayerwin],
        gametype: map[SqlDatabase.columnGametype],
        date: DateTime.parse(map[SqlDatabase.columnDate]));

  }

  @override
  String toString() {
    return 'HistoryPlay{id: $id, playerwin: $playerwin, gametype: $gametype, date: $date}';
  }
}
