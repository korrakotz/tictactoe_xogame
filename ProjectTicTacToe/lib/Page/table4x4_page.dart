import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../history.dart';

class Table4x4Page extends StatefulWidget {
  @override
  _Table4x4State createState() => _Table4x4State();
}

class _Table4x4State extends State<Table4x4Page> {
  static Future<SqlDatabase> database = SqlDatabase.creteInstance();
  DateTime _dateTime = DateTime.now();
  static const double RADIUS_CORNER = 12;
  static const int NONE = 0;
  static const int VALUE_X = 1;
  static const int VALUE_O = 2;
  int currentTurn = VALUE_X;

  // State of Game
  List<List<int>> channelStatus = [
    [NONE, NONE, NONE, NONE],
    [NONE, NONE, NONE, NONE],
    [NONE, NONE, NONE, NONE],
    [NONE, NONE, NONE, NONE],
  ];

  void switchPlayer() {
    if (currentTurn == VALUE_X) {
      currentTurn = VALUE_O;
    } else if (currentTurn == VALUE_O) {
      currentTurn = VALUE_X;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color(0xFF701ebd),
                // Color(0xFFfe4a97),
                Color(0xFF02021A),
                Color(0xFF072F71),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("ผู้เล่นคนที่ "+currentTurn.toString(),
                  style: TextStyle(
                      fontSize: 36, color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Icon(getIconFromStatus(currentTurn), size: 60, color: Colors.white),
              SizedBox(height: 5),
              Container(
                  color: Colors.green[500],
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildRowChannel(0)),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildRowChannel(1)),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildRowChannel(2)),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildRowChannel(3))
                    ],
                  )),
            ],
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showrules();
        },

        child: const Icon(Icons.info,size: 55),
      ),
    );
  }

  GestureDetector buildChannel(int row, int col, double tlRadius,
          double trRadius, double blRadius, double brRadius, int status) =>
      GestureDetector(
        onTap: () => onChannelPressed(row, col),
        child: Container(
            margin: EdgeInsets.all(2),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: getBackgroundChannelFromStatus(status),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(tlRadius),
                    topRight: Radius.circular(trRadius),
                    bottomLeft: Radius.circular(blRadius),
                    bottomRight: Radius.circular(brRadius))),
            child: Icon(getIconFromStatus(status),
                size: 60, color: Colors.green[800])),
      );

  IconData? getIconFromStatus(int status) {
    if (status == 1) {
      return Icons.close;
    } else if (status == 2) {
      return Icons.radio_button_unchecked;
    }
    return null;
  }

  Color colorBorder = Colors.green.shade600;
  Color colorBackground = Colors.green.shade100;
  Color colorBackgroundChannelNone = Colors.green.shade200;
  Color colorBackgroundChannelValueX = Colors.green.shade300;
  Color colorBackgroundChannelValueO = Colors.green.shade300;
  Color colorChannelIcon = Colors.green.shade800;

  Color getBackgroundChannelFromStatus(int status) {
    if (status == 1) {
      return Colors.green.shade300;
    } else if (status == 2) {
      return Colors.green.shade300;
    }
    return Colors.green.shade100;
  }

  onChannelPressed(int row, int col) {
    if (channelStatus[row][col] == NONE) {
      setState(() {
        channelStatus[row][col] = currentTurn;
        if (isGameEndedByWin()) {
          database.then((db) =>{
            db.addHistory(HistoryPlay(
              playerwin :"ผู้เล่นคนที่ "+currentTurn.toString(),
              date : _dateTime, gametype: '4x4',
            )
            ).then((value) => {

            })

          });
          showEndGameDialog(currentTurn);
        } else {
          if (isGameEndedByDraw()) {
            database.then((db) =>{
              db.addHistory(HistoryPlay(
                playerwin :"ไม่มีผู้ชนะในเกมนี้",
                date : _dateTime,
                gametype: '4x4',
              )
              ).then((value) => {

              })
            });
            showEndGameByDrawDialog();
          } else {
            switchPlayer();
          }
        }
      });
    }
  }

  List<Widget> buildRowChannel(int row) {
    List<Widget> listWidget = [];
    for (int col = 0; col < 4; col++) {
      double tlRadius = row == 0 && col == 0 ? RADIUS_CORNER : 0;
      double trRadius = row == 0 && col == 3 ? RADIUS_CORNER : 0;
      double blRadius = row == 3 && col == 0 ? RADIUS_CORNER : 0;
      double brRadius = row == 3 && col == 3 ? RADIUS_CORNER : 0;
      Widget widget = buildChannel(row, col, tlRadius, trRadius, blRadius,
          brRadius, channelStatus[row][col]);
      listWidget.add(widget);
    }
    return listWidget;
  }

  bool isGameEndedByWin() {
    // check vertical.
    for (int col = 0; col < 4; col++) {
      if ((channelStatus[0][col] != NONE &&
              channelStatus[0][col] == channelStatus[1][col] &&
              channelStatus[1][col] == channelStatus[2][col]) ||
          channelStatus[3][col] != NONE &&
              channelStatus[3][col] == channelStatus[2][col] &&
              channelStatus[2][col] == channelStatus[1][col]) {
        return true;
      }
    }

    // check horizontal.
    for (int row = 0; row < 4; row++) {
      if ((channelStatus[row][0] != NONE &&
              channelStatus[row][0] == channelStatus[row][1] &&
              channelStatus[row][1] == channelStatus[row][2]) ||
          channelStatus[row][3] != NONE &&
              channelStatus[row][3] == channelStatus[row][2] &&
              channelStatus[row][2] == channelStatus[row][1]) {
        return true;
      }
    }

    // check cross left to right.
    if ((channelStatus[0][0] != NONE &&
            channelStatus[0][0] == channelStatus[1][1] &&
            channelStatus[1][1] == channelStatus[2][2]) ||
        channelStatus[3][3] != NONE &&
            channelStatus[3][3] == channelStatus[2][2] &&
            channelStatus[2][2] == channelStatus[1][1]) {
      return true;
    }
    if ((channelStatus[1][0] != NONE &&
        channelStatus[1][0] == channelStatus[2][1] &&
        channelStatus[2][1] == channelStatus[3][2]) ||
        (channelStatus[0][1] != NONE &&
            channelStatus[0][1] == channelStatus[1][2] &&
            channelStatus[1][2] == channelStatus[2][3])) {
      return true;
    }


    // check cross right to left.
    if ((channelStatus[0][3] != NONE &&
        channelStatus[0][3] == channelStatus[1][2] &&
        channelStatus[1][2] == channelStatus[2][1]) ||
        channelStatus[3][0] != NONE &&
            channelStatus[3][0] == channelStatus[2][1] &&
            channelStatus[2][1] == channelStatus[1][2]) {
      return true;
    }
    if ((channelStatus[0][2] != NONE &&
        channelStatus[0][2] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][0]) ||
        channelStatus[1][3] != NONE &&
            channelStatus[1][3] == channelStatus[2][2] &&
            channelStatus[2][2] == channelStatus[3][1]) {
      return true;
    }


    return false;
  }

  bool isGameEndedByDraw() {
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (channelStatus[row][col] == NONE) {
          return false;
        }
      }
    }
    return true;
  }

  void showEndGameDialog(int winner) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("ผู้ชนะได้แก่! ", style: TextStyle(
                      fontSize: 32,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold)),
                  Text("ผู้เล่นคนที่ "+currentTurn.toString(), style: TextStyle(
                      fontSize: 32,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                    child: ElevatedButton(
                      child: Text("เริ่มเกมใหม่",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        playAgain();
                        Navigator.pop(context);

                      },
                    ),
                  )
                ])
        );
      },
    );
  }
  void showEndGameByDrawDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("ไม่มีผู้ชนะในเกมนี้", style: TextStyle(
                      fontSize: 32,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                    child: ElevatedButton(
                      child: Text("เริ่มเกมใหม่",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        playAgain();
                        Navigator.pop(context);


                      },
                    ),
                  ),
                ])
        );
      },
    );
  }
  void showrules() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("กติกา", style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                  Text("คุณต้องวาง X หรือ O ติดต่อกัน3ตัว เพื่อชนะเกม", style: TextStyle(
                      fontSize: 25,
                      color:  Color(0xFF072F71),
                      fontWeight: FontWeight.w600)),
                ])
        );
      },
    );
  }
  playAgain() {
    setState(() {
      currentTurn = VALUE_X;
      channelStatus = [
        [NONE, NONE, NONE, NONE],
        [NONE, NONE, NONE, NONE],
        [NONE, NONE, NONE, NONE],
        [NONE, NONE, NONE, NONE],
      ];
    });
  }
}
