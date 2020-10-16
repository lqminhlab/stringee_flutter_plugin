import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:stringee_flutter_plugin_example/form_call.dart';
import 'package:stringee_flutter_plugin_example/form_chat.dart';

var client = StringeeClient();
var user1 =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InN0cmluZ2VlLWFwaTt2PTEifQ.eyJqdGkiOiJTS0RFRWdoV2U4Q2hsZ1JYdGVTd2hqaDZQeWgwMXRZdnItMTYwNTQyMTIxNiIsInVzZXJJZCI6IjIxMzYyMzM2NTkiLCJleHAiOjE2MDU0MjEyMTYsImlzcyI6IlNLREVFZ2hXZThDaGxnUlh0ZVN3aGpoNlB5aDAxdFl2ciJ9.You0b5g931dwuRS6Qn5Zsd7BCxSMXek2m8keZmR_qQA';
var user2 =
    '';

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
