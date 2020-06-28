import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App Example',
        home: TextWriterApp(title: 'Text Write Example'),
    );
  }
}

class TextWriterApp extends StatefulWidget {

  final String title;

  TextWriterApp({Key key, this.title}) : super(key: key);

  @override
  ActionApp createState() {
    return ActionApp();
  }
}

class ActionApp extends State<TextWriterApp> {

  String inputText = 'input text : \n';
  TextEditingController textEditingController = new TextEditingController();

  void addText(String text) {
    setState(() {
      inputText = inputText + text + '\n';
    });

    var headers = {'Content-Type': 'application/json'};
    var requestBody = {
      'fromUser': 'minssogi',
      'text': text,
    };

    http.post(
        "http://localhost:8080/message/send",
        headers: headers,
        body: jsonEncode(requestBody),
    ).then((value) => {
      value.statusCode == 200 ? textEditingController.clear() : print('데이터 저장 실패!!'),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: addText,
                    ),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => addText(textEditingController.text)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(100),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text('$inputText'),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}

