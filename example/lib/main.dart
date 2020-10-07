import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:stringee_flutter_plugin_example/form_call.dart';
import 'package:stringee_flutter_plugin_example/form_chat.dart';

var client = StringeeClient();
var user1 =
    'eyJjdHkiOiJzdHJpbmdlZS1hcGk7dj0xIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJqdGkiOiJTS0RFRWdoV2U4Q2hsZ1JYdGVTd2hqaDZQeWgwMXRZdnItMTYwMjA3MjI1OSIsImlzcyI6IlNLREVFZ2hXZThDaGxnUlh0ZVN3aGpoNlB5aDAxdFl2ciIsImV4cCI6MTYwNDY2NDI1OSwidXNlcklkIjoibGFiX3VzZXIwMSJ9.398uKG77aBqp44aYYWXKDPHzSjQDLhruou4nRGhq__o';
var user2 =
    'eyJjdHkiOiJzdHJpbmdlZS1hcGk7dj0xIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJqdGkiOiJTS0RFRWdoV2U4Q2hsZ1JYdGVTd2hqaDZQeWgwMXRZdnItMTYwMjA3MjI5OCIsImlzcyI6IlNLREVFZ2hXZThDaGxnUlh0ZVN3aGpoNlB5aDAxdFl2ciIsImV4cCI6MTYwNDY2NDI5OCwidXNlcklkIjoibGFiX3VzZXIwMiJ9.Ht9JUmdLGO2_y3qL8iqbGIHGjipKDMf8jj83yZzomwk';

void main() {
  runApp(new MyApp());
}

enum StringeeSampleType { call, chat }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: "StringeeSample", home: new MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    client.connect(user1);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: new Text(
                'Select your type you want?',
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      "CALL",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    color: Colors.blue[300],
                    onPressed: () {
                      handleTapEvent(StringeeSampleType.call);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "CHAT",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    color: Colors.blue[300],
                    onPressed: () {
                      handleTapEvent(StringeeSampleType.chat);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleTapEvent(StringeeSampleType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              type == StringeeSampleType.call ? FormCall() : FormChat()),
    );
  }
}
