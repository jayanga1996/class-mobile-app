import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodbuy/Assignments/Theory01/t1_ass01.dart';

class AssignmentList extends StatefulWidget {
  @override
  _AssignmentListState createState() => _AssignmentListState();
}

final firestoreInstance = Firestore.instance;

class _AssignmentListState extends State<AssignmentList> {
  TextEditingController regNumFieldTheory = new TextEditingController();
  TextEditingController regNumFieldRevision = new TextEditingController();
  FirebaseUser user;
  Firestore data;
  String _regNumber1, _regNumber2, regNum;
  bool valid = false;
  void dispose() {
    // Clean up the controller when the widget is disposed.
    regNumFieldTheory.dispose();
    regNumFieldRevision.dispose();
    super.dispose();
  }

  Widget showRegNumInputTheory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: regNumFieldTheory,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Registration Number',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        // ignore: missing_return
        validator: (input) {
          if (input.length < 5) {
            return ' Invalid Registration Number';
          }
        },
        onSaved: (input) => _regNumber1 = input,
      ),
    );
  }

  Widget showRegNumInputRevision() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: regNumFieldRevision,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Registration Number',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        // ignore: missing_return
        validator: (input) {
          if (input.length < 5) {
            return ' Invalid Registration Number';
          }
        },
        onSaved: (input) => _regNumber2 = input,
      ),
    );
  }

  Widget getRegNum() {
    return StreamBuilder(
        stream: firestoreInstance.collection('Users').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot user = snapshot.data.documents[index];
              return Container(
                child: Image.network(
                  user['regNum'],
                  height: 100,
                  width: 200,
                ),
                //title: Text(user['regNum']),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
            bottom: TabBar(tabs: [
              Container(
                child: Text('Theory',
                    style: TextStyle(fontSize: 25.0, color: Colors.black)),
              ),
              Container(
                  child: Text('Revision',
                      style: TextStyle(fontSize: 25.0, color: Colors.black))),
            ]),
          ),
          body: TabBarView(children: [
            tab1(),
            tab2(),
          ]),
        ),
      ),
    );
  }

  Widget tab1() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 80,
                  child: showRegNumInputTheory(),
                ),
                Expanded(
                  flex: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          var firebaseUser =
                              await FirebaseAuth.instance.currentUser();
                          firestoreInstance
                              .collection("Users")
                              .document(firebaseUser.uid)
                              .get()
                              .then((value) {
                            //print(value.data['regNum']);
                            String register = value.data['regNum'];
                            //regNumField.text=value.data['regNum'];
                            if (register == regNumFieldTheory.text) {
                              setState(() {
                                valid = true;
                                regNumFieldTheory.clear();
                              });
                            } else {
                              setState(() {
                                regNumFieldTheory.text = 'Try Again';
                              });
                            }
                          });
                        },
                      ),
                      //color: Colors.deepPurple[200],
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
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
          ),
          /*Container(
            
          ),*/
          valid == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250.0,
                    child: RaisedButton(
                        //padding:const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                        color: Colors.black54,
                        child: Text('Assigment 01'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ass01_t1_Page(),
                              ));
                        }),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                  child: Text(
                    'You are not alloweed',
                    textAlign: TextAlign.center,
                  ),
                ),
          valid == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250.0,
                    child: RaisedButton(
                        //padding:const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                        color: Colors.black54,
                        child: Text('Assigment 01'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ass01_t1_Page(),
                              ));
                        }),
                  ),
                )
              : Offstage(),
          valid == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250.0,
                    child: RaisedButton(
                        //padding:const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                        color: Colors.black54,
                        child: Text('Assigment 01'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ass01_t1_Page(),
                              ));
                        }),
                  ),
                )
              : Offstage(),
        ],
      ),
    );
  }

  Widget tab2() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 80,
                  child: showRegNumInputRevision(),
                ),
                Expanded(
                  flex: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 30.0,
                        ),
                        onPressed: () {},
                      ),
                      //color: Colors.deepPurple[200],
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
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
          ),
        ],
      ),
    );
  }
}
