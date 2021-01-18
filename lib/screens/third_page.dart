import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
            backgroundColor: Colors.white,
            
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 45.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logo.png')),
                    ),
                  ),
                ],
              ),
            ],
      ) ,
      body: Container(
        height: 500,
        width: 400,
        child: Image(image: AssetImage('assets/images/tute2.png')),
      ),
    );
  }
}