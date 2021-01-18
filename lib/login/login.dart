//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:goodbuy/screens/home_page.dart';
import 'sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/rendering/box.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.black);
  final firestoreInstance = Firestore.instance;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  String _email, _password;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////Email Field/////////////////////////
    /*final emailField = TextField(
      //autofocus: true,
      controller: myController1,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

  ///////////////////////////////password Field////////////////////////
  
    final passwordField = TextField(
      controller: myController2,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
         final signInButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignInPage()));
        },
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

  
    Widget showLogo() {
      return new Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48.0,
            child: Image.asset('assets/images/rush.png'),
          ),
        ),
      );
    }
*/
    Future<void> signIn() async {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        try {
          AuthResult user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          setState(() {
            myController2.text = '';
          });
        } catch (e) {
          print(e.Message);
        }
      }
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.80,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          signIn();
        },

        /*async {
          if (myController1.text != 'jayanga' || myController2.text != '1234') {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text('Retry please'),
                );
              },
            );
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          }
        },
        */
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Widget createAccount() {
      return new FlatButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignInPage()));
        },
        child: new Text(
          'Create Account...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      );
    }

    Widget showEmailInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController1,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Email',
              icon: new Icon(
                Icons.mail,
                color: Colors.grey,
              )),
          // ignore: missing_return
          validator: (input) {
            if (input.isEmpty) {
              return 'Email can\'t be empty';
            }
          },
          onSaved: (input) => _email = input,
        ),
      );
    }

    Widget showPasswordInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController2,
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Password',
              icon: new Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          // ignore: missing_return
          validator: (input) {
            if (input.length < 6) {
              return 'Password must be 6 Character';
            }
          },
          onSaved: (input) => _password = input,
        ),
      );
    }
    Widget getImageLink() {
    return StreamBuilder(
        stream: firestoreInstance.collection('Images').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot link = snapshot.data.documents[index];
              return Container(
                child: Image.network(
                  link['imgLink'],
                  height: 50.0,
                  width: 75.0,
                ),
                //title: Text(user['regNum']),
              );
            },
          );
        });
  }

    return Scaffold(
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
            ],
          ),
          /* Padding(
            padding: const EdgeInsets.all(10.0),
            child: signInButon,
          ),
          */
        ],
        bottom: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(10)),
        elevation: 20.0,
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.network('https://firebasestorage.googleapis.com/v0/b/nova-physics-academy.appspot.com/o/1.png?alt=media&token=adef0eb1-e526-4e29-82f5-63af54b8a790'),
                          showEmailInput(),
                          SizedBox(height: 25.0),
                          showPasswordInput(),
                          SizedBox(
                            height: 25.0,
                          ),
                          loginButon,
                          SizedBox(
                            height: 15.0,
                          ),
                          createAccount(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
