import 'package:flutter/material.dart';
import 'package:goodbuy/include/assignment.dart';
import 'package:goodbuy/include/tute.dart';
import 'package:goodbuy/login/login.dart';
import 'second_page.dart';
import 'video_play.dart';
import 'third_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Nova Physics Accademy',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.lightGreen,
      ),
      home: AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.black);

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text('Do you want to sign out..?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AppHomePage()));
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final signOutButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        onPressed: () {
          //child:
          _showMyDialog();
        },
        child: Text("Sign out",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
//**************************APPBAR TAG**********************//

      appBar: AppBar(
        backgroundColor: Colors.white,
        /*title: Text(
          'goodBuy.lk',
        ),
        */
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black), onPressed: () {}),
        actions: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 45.0,
                width: 120.0,
                //alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  /*  border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                          */
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.png')),
                ),
              ),
              Container(
                width: 30.0,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: signOutButon,
          ),
        ],
        bottom: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(10)),
        elevation: 20.0,
      ),

//*************************BODY TAG****************************//

      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
////////////////////////////////////Level 01//////////////////////////////////////////
            /*  Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //color: Colors.lightBlue[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                          )
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                        onPressed: () {},
                      ),
                      //color: Colors.deepPurple[200],
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
            Divider(
              color: Colors.black,
            ),
////////////////////////////Level 01//////////////////////////////////////////

////////////////////////////////Level 02///////////////////////////////////////
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                        image: DecorationImage(
                            //fit: BoxFit.cover,
                            image: AssetImage('assets/images/poster1.jpeg')),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.black26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                        image: DecorationImage(
                            //fit: BoxFit.cover,
                            image: AssetImage('assets/images/poster2.jpeg')),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                        image: DecorationImage(
                            //fit: BoxFit.cover,
                            image: AssetImage('assets/images/logo.jpeg')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 15.0,
              thickness: 3.0,
            ),
//////////////////////////Level 02/////////////////////////////////////

/////////////////////////////Level 03/////////////////////////////////
            Container(
              alignment: Alignment.topLeft,
              height: 500,
              width: MediaQuery.of(context).size.width,
              //color: Colors.blueAccent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
//*************************Level 03 Main Column Start************************//
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //SizedBox(height: 10,width:10 ,

//***********************Level 03 Main Row 01**************************//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // SizedBox(
                          //  width: 15,
                          //  height: 15,
                          //),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                //color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                // image: DecorationImage(
                                //   image: AssetImage('assets/images/rush.png')),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return TuteList ();
                                              }));
                                              //Navigator.of(context).pushNamed("/second");
                                            },
                                            child: Image.asset(
                                                'assets/images/tute2.png',
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.lightGreen,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                //color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                /* image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rush.png')),
                              */
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return AssignmentList();
                                              }));
                                            },
                                            child: Image.asset(
                                                'assets/images/ass.png',
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.lightGreen,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                //color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                /* image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rush.png')),
                              */
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return SecondPage();
                                              }));
                                            },
                                            child: Image.asset(
                                                'assets/images/result.png',
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.lightGreen,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

//***********************Level 03 Main Row 02*******************//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // SizedBox(
                          // width: 15,
                          // height: 15,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                /* image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rush.png')),
                              */
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        // ignore: missing_required_param
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return VideoPlayerScreen();
                                            }));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        /*child: Text(
                                        'Who am I...?',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 20),
                                      ),*/
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                /*image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rush.png')),
                              */
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        /* child: FlatButton(
                                        onPressed: () {},
                                        child: Image.asset(
                                           'assets/images/rush.png')
                                      ),*/
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        /*child: Text(
                                        'Who am I...?',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 20),
                                      ),*/
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                /*  image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rush.png')),
                            */
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //alignment: Alignment.center,
                                        height: 165,
                                        width: 180,
                                        /*child: FlatButton(
                                        onPressed: () {},
                                         child: Image.asset(
                                             'assets/images/1.jpg')
                                      ),*/
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        /*child: Text(
                                        'Who am I...?',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 20),
                                      ),*/
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

//*************************Level 03 Main Column End************************//
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 3.0,
            ),
////////////////////////Level 03////////////////////////////
            ///
            ///
////////////////////////Level 04////////////////////////////
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
            ),
          ],
        ),
      ),
////////////////////////Level 04////////////////////////////
    );
  }
}
