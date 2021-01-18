import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';


// ignore: camel_case_types
class Tute01_r_Page extends StatefulWidget {
  Tute01_r_Page({Key key}) : super(key: key);

  @override
  _Tute01_r_PageState createState() => _Tute01_r_PageState();
}

// ignore: camel_case_types
class _Tute01_r_PageState extends State<Tute01_r_Page> {
  String urlPDFPath1 = "";


 void initState() {
    super.initState();
    getFileFromUrl('https://firebasestorage.googleapis.com/v0/b/nova-physics-academy.appspot.com/o/practical01.pdf?alt=media&token=48d9c67a-974e-4e77-84b8-51c75d3907c0')
    .then((f) {
      setState(() {
          urlPDFPath1 = f.path;
      });
      print(urlPDFPath1);
    });
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text("PDF Viewer"),
          ),
          body: Center(
            child: Builder(
                builder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.amber,
                            child: Text('Assignment 01'),
                            onPressed: () {
                              getFileFromUrl('https://firebasestorage.googleapis.com/v0/b/nova-physics-academy.appspot.com/o/practical01.pdf?alt=media&token=48d9c67a-974e-4e77-84b8-51c75d3907c0')
                                .then((f) {
                                  setState(() {
                                      urlPDFPath1 = f.path;
                                  });
                                  print(urlPDFPath1);
                                });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewPage(
                                      path: urlPDFPath1,
                                    ),
                                  ));
                              //print(urlPDFPath);
                            }),
                      ],
                    )),
          ),
        ));
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;
  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  bool pdfReady = false;
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyDocument'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: true,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}
