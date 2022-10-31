import 'package:flutter/material.dart';

import 'Page/history_page.dart';

import 'Page/select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAME TIC TAC TOE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Kannit',
      ),
      home: const MyHomePage(title: 'GAMETICTACTOE_Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
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
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {

                  },
                  child: Image(
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.cover,
                    height: 300,
                  )
              ),
            SizedBox(height: 50),
            //  Text("เกมXO",style: TextStyle(fontSize:50,color:Colors.white,fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('เริ่มเกม',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontFamily: 'Kannit' )),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade600,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => SelectPage()));
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('ประวัติการเล่น',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontFamily: 'Kannit')),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink.shade500,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => HistoryPage()));
                    },
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
