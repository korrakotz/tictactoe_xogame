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
              Color(0xFF701ebd),
              Color(0xFFfe4a97),
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
              Image.network('https://cdn.dribbble.com/users/1737220/screenshots/9185255/media/681935e296d28fc0925a966342306c67.jpg?compress=1&resize=400x300'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('เริ่มเกม',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
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
                    child: Text('ประวัติการเล่น',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
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
