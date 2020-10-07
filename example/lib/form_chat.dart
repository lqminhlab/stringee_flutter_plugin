import 'package:flutter/material.dart';

class FormChat extends StatefulWidget {
  @override
  _FormChatState createState() => _FormChatState();
}

class _FormChatState extends State<FormChat> {
  String myUserId = 'Not connected...';

  @override
  Widget build(BuildContext context) {
    Widget topText = new Container(
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      child: new Text(
        'Connected as: $myUserId',
        style: new TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("OneToOneChatSample"),
        backgroundColor: Colors.indigo[600],
      ),
      body: new Stack(
        children: <Widget>[
          topText,
          new MyForm(),
        ],
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFormState();
  }
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Form(
//      key: _formKey,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(20.0),
            child: new TextField(
              onChanged: (String value) {
                _changeText(value);
              },
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
          new Container(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    color: Colors.grey[300],
                    textColor: Colors.black,
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    onPressed: _voiceCallTapped,
                    child: Text('Connect chat'),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _changeText(String val) {
    print("Change: $val");
  }

  void _voiceCallTapped() {
    print("Tap connect chat");
  }
}