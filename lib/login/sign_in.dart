import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:goodbuy/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:goodbuy/models/users.dart';
//import 'package:goodbuy/screens/home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // ignore: unused_field
  File _imageFile;
  bool _uploaded = false;
  String _downloadUrl;
  String _email, _newPassword, _comfirmedPassword, _regNum;
  StorageReference _reference =
      FirebaseStorage.instance.ref().child('myImage.jpg');

  Future getImage(bool isCamera) async {
    // ignore: deprecated_member_use
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapsot = await uploadTask.onComplete;
    setState(() {
      _uploaded = true;
    });
  }

  Future downloadImage() async {
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }

  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.black);

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget showRegNumInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController1,
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
          onSaved: (input) => _regNum = input,
        ),
      );
    }

    Widget showEmailInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController2,
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

    Widget showNewPasswordInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController3,
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'New Password',
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
          onSaved: (input) => _newPassword = input,
        ),
      );
    }

    Widget showComfirmedPasswordInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: new TextFormField(
          controller: myController4,
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Comfirm Password',
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
          onSaved: (input) => _comfirmedPassword = input,
        ),
      );
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ooopsss....'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //Text('This is a demo alert dialog.'),
                  Text('Password Comfiremation Error...Try Again'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignInPage()));
                  //  myController3.text = _email;
                  //  myController1.clear();
                  //  myController2.clear();
                },
              ),
              /*FlatButton(
                child: Text('Yes'),
                onPressed: () {
                   Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AppHomePage()));
                },
              ),
              */
            ],
          );
        },
      );
    }
    /////////////////////////////////////Database Connection///////////////////////////////////////////////

  Future<void> addUser() async {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      Users user =
          Users(email: _email, password: _newPassword, regNum: _regNum);
      try {
        Firestore.instance.runTransaction((Transaction transaction) async {
          await Firestore.instance
              .collection('Users')
              .document(firebaseUser.uid)
              .setData(user.tojson());
        });
      } catch (e) {
        print(e.toString());
      }
    }

    ////////////////////////////////////////Database Connection////////////////////////////////////////////

    Future<void> signUp() async {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email, password: _newPassword);
          //_showMyDialog();
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          //addUser Method call
          addUser();
          /*   Firestore.instance.collection("users").add({
              "email": _email,
              "password": _newPassword,
              "regNum": _regNum,
            }).then((value) {
              print(value.documentID);
            });
            */
        } catch (e) {
          print(e.Message);
        }
      }
    }

    Future<void> _submitDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Succesfully'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //Text('This is a demo alert dialog.'),
                  Text('Welcome To Nova Physics Academy'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  signUp();
                },
              ),
              /*FlatButton(
                child: Text('Yes'),
                onPressed: () {
                   Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AppHomePage()));
                },
              ),
              */
            ],
          );
        },
      );
    }

    // ignore: unused_local_variable
    final submitButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        onPressed: () {
          if (myController3.text != myController4.text) {
            _showMyDialog();
            //return 'Password Comfirmation Error';
          } else {
            _submitDialog();
          }
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
        bottom: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(10)),
        elevation: 20.0,
      ),
      body: Form(
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
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 120.0,
                          //alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          child: _imageFile == null
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 30.0, 10.0, 10.0),
                                  child: Text(
                                    'Add your Photo',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Image.file(
                                  _imageFile,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                          height: 50.0,
                          child: FloatingActionButton(
                            onPressed: () {
                              getImage(false);;
                            },
                            child: Icon(Icons.camera_alt),
                          ),
                        ),

                          _imageFile==null ? Container(): RaisedButton(
                            onPressed: () {
                              uploadImage();
                            },
                          ),
                        showRegNumInput(),
                        showEmailInput(),
                        showNewPasswordInput(),
                        showComfirmedPasswordInput(),
                        SizedBox(
                          height: 25,
                        ),
                        submitButon,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
