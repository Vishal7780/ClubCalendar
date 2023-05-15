import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        color: Colors.black87,
        padding: EdgeInsets.fromLTRB(0, 300, 0, 300),
        child:Center(child:Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),

              height: 80,
              width: 80,

              child: ClipRRect(

                child: Image.asset('assets/CC-Logo(1).png'),


              ),
            ),

          ],
        )),

      ),
    );
  }
}
