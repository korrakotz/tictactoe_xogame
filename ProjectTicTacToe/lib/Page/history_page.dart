import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecttictactoe/history.dart';

import '../database.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  static Future<SqlDatabase> database = SqlDatabase.creteInstance();
  List<HistoryPlay> List3x3 = [];
  List<HistoryPlay> List4x4 = [];
  List<HistoryPlay> List5x5 = [];
  List<HistoryPlay> List6x6 = [];
  bool isLoading = true;

  @override
  void initState() {
    refreshHistory();
    super.initState();
  }

  void refreshHistory() {
    setState(() {
      isLoading = true;
    });

    database.then((db) => {
          db.get3x3History().then((list) => {
                List3x3 = list,
                setState(() {
                  isLoading = false;
                }),
           print(List3x3.toString()),
              })
        });

    database.then((db) => {
      db.get4x4History().then((list) => {
        List4x4 = list,
        setState(() {
          isLoading = false;
        }),
        print(List4x4.toString()),
      })
    });

    database.then((db) => {
      db.get5x5History().then((list) => {
        List5x5 = list,
        setState(() {
          isLoading = false;
        }),
        print(List5x5.toString()),
      })
    });

    database.then((db) => {
      db.get6x6History().then((list) => {
        List6x6 = list,
        setState(() {
          isLoading = false;
        }),
        print(List6x6.toString()),
      })
    });


  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple ,
          bottom:  TabBar(
            tabs: [
              Tab(text: "3x3"),
              Tab(text: "4x4"),
              Tab(text: "5x5"),
              Tab(text: "6x6"),
            ],
          ),
          title: const Text('ประวัติการเล่น',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
        ),
        body:  TabBarView(
          children: [
            List3x3.length == 0 ? Container(width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF701ebd),
                      Color(0xFFfe4a97),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),child: Center(child: Text("ยังไม่มีประวัติการเล่น",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)))): table3x3(),
            List4x4.length == 0 ? Container(width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF701ebd),
                      Color(0xFFfe4a97),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),child: Center(child: Text("ยังไม่มีประวัติการเล่น",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)))):    table4x4(),
            List5x5.length == 0 ? Container(width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF701ebd),
                      Color(0xFFfe4a97),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),child: Center(child: Text("ยังไม่มีประวัติการเล่น",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)))):    table5x5(),
            List6x6.length == 0 ? Container(width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF701ebd),
                      Color(0xFFfe4a97),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),child: Center(child: Text("ยังไม่มีประวัติการเล่น",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)))): table6x6(),
              ],
      ),
      ),
    );
  }

  Widget table3x3(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF701ebd),
            Color(0xFFfe4a97),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: List3x3.length,
              itemBuilder: (context, index) {
                String date = List3x3[index].date.day.toString()+"-"+
                    List3x3[index].date.month.toString()+"-"+
                    List3x3[index].date.year.toString()+"  ";
                final timesplit = List3x3[index].date.toString().split(" ");
                final time = timesplit[1].substring(0,5);
                return Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 12.0,right: 10),
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("โหมดการเล่น"+List3x3[index].gametype.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              List3x3[index].playerwin=="ไม่มีผู้ชนะในเกมนี้"? Flexible(child: Text(" "+List3x3[index].playerwin.toString(),style: TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold))):
                              Flexible(child: Text(" ผู้ชนะได้แก่"+List3x3[index].playerwin.toString(),style: TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold)))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("วันที่ "+date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                              Text("เวลา "+time+" น.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                            ],
                          ),



                        ],
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget table4x4(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF701ebd),
            Color(0xFFfe4a97),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: List4x4.length,
              itemBuilder: (context, index) {
                String date = List4x4[index].date.day.toString()+"-"+
                    List4x4[index].date.month.toString()+"-"+
                    List4x4[index].date.year.toString()+"  ";
                final timesplit = List4x4[index].date.toString().split(" ");
                final time = timesplit[1].substring(0,5);
                return Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 12.0,right: 10),
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("โหมดการเล่น"+List4x4[index].gametype.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              List4x4[index].playerwin=="ไม่มีผู้ชนะในเกมนี้"? Flexible(child: Text(" "+List4x4[index].playerwin.toString(),style: TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold))):
                              Flexible(child: Text(" ผู้ชนะได้แก่"+List4x4[index].playerwin.toString(),style: TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold)))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("วันที่ "+date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                              Text("เวลา "+time+" น.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                            ],
                          ),



                        ],
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget table5x5(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF701ebd),
            Color(0xFFfe4a97),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: List5x5.length,
              itemBuilder: (context, index) {
                String date = List5x5[index].date.day.toString()+"-"+
                    List5x5[index].date.month.toString()+"-"+
                    List5x5[index].date.year.toString()+"  ";
                final timesplit = List5x5[index].date.toString().split(" ");
                final time = timesplit[1].substring(0,5);
                return Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 12.0,right: 10),
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("โหมดการเล่น"+List5x5[index].gametype.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              List5x5[index].playerwin=="ไม่มีผู้ชนะในเกมนี้"? Flexible(child: Text(" "+List5x5[index].playerwin.toString(),style: TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold))):
                              Flexible(child: Text(" ผู้ชนะได้แก่"+List5x5[index].playerwin.toString(),style: TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold)))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("วันที่ "+date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                              Text("เวลา "+time+" น.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                            ],
                          ),



                        ],
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget table6x6(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF701ebd),
            Color(0xFFfe4a97),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: List6x6.length,
              itemBuilder: (context, index) {
                String date = List6x6[index].date.day.toString()+"-"+
                    List6x6[index].date.month.toString()+"-"+
                    List6x6[index].date.year.toString()+"  ";
                final timesplit = List6x6[index].date.toString().split(" ");
                final time = timesplit[1].substring(0,5);
                return Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 12.0,right: 10),
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("โหมดการเล่น"+List6x6[index].gametype.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              List6x6[index].playerwin=="ไม่มีผู้ชนะในเกมนี้"? Flexible(child: Text(" "+List6x6[index].playerwin.toString(),style: TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold))):
                              Flexible(child: Text(" ผู้ชนะได้แก่"+List6x6[index].playerwin.toString(),style: TextStyle(color:Colors.green,fontSize: 18,fontWeight: FontWeight.bold)))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("วันที่ "+date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                              Text("เวลา "+time+" น.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                            ],
                          ),



                        ],
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
