import 'package:flutter/material.dart';

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
    textEditingController.clear();
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

