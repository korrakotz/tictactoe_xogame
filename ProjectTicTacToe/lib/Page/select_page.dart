import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecttictactoe/Page/table3x3_page.dart';
import 'package:projecttictactoe/Page/table4x4_page.dart';
import 'package:projecttictactoe/Page/table5x5_page.dart';
import 'package:projecttictactoe/Page/table6x6_page.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
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
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              /*mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,*/
              children: [
                SizedBox(height: 45),

                Container(
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(

                    color: Colors.white,
                    height: 25.0,
                  ),
                ),
                Text('กรุณาเลือกตาราง',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 38)),
                Container(
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(

                    color: Colors.white,
                    height: 25.0,
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Table3x3Page()));
                        },
                        child: Image(
                          image: AssetImage('assets/img/3x3table.png'),
                          fit: BoxFit.cover,
                          height: 150,
                        )
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Table4x4Page()));
                        },
                        child: Image(
                          image: AssetImage('assets/img/4x4table.png'),
                          fit: BoxFit.cover,
                          height: 150,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Table5x5Page()));
                        },
                        child: Image(
                          image: AssetImage('assets/img/5x5table.png'),
                          fit: BoxFit.cover,
                          height: 150,
                        )
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Table6x6Page()));
                        },
                        child: Image(
                          image: AssetImage('assets/img/6x6table.png'),
                          fit: BoxFit.cover,
                          height: 150,
                        )
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }


}