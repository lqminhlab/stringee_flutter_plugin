import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';

import 'Call.dart';
import 'main.dart';

class FormCall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormCallState();
  }
}

class _FormCallState extends State<FormCall> {
  String myUserId = 'Not connected...';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myUserId = client.userId;

    // Lắng nghe sự kiện của StringeeClient(kết nối, cuộc gọi đến...)
    client.eventStreamController.stream.listen((event) {
      Map<dynamic, dynamic> map = event;
      StringeeClientEventType eventType = map['eventType'];
      switch (eventType) {
        case StringeeClientEventType.DidConnect:
          handleDidConnectEvent();
          break;
        case StringeeClientEventType.DidDisconnect:
          handleDiddisconnectEvent();
          break;
        case StringeeClientEventType.DidFailWithError:
          break;
        case StringeeClientEventType.RequestAccessToken:
          break;
        case StringeeClientEventType.DidReceiveCustomMessage:
          break;
        case StringeeClientEventType.IncomingCall:
          StringeeCall call = map['body'];
          handleIncomingCallEvent(call);
          break;
        default:
          break;
      }
    });
  }

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
        title: new Text("OneToOneCallSample"),
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

  //region Handle Client Event
  void handleDidConnectEvent() {
    setState(() {
      myUserId = client.userId;
    });
  }

  void handleDiddisconnectEvent() {
    setState(() {
      myUserId = 'Not connected...';
    });
  }

  void handleIncomingCallEvent(StringeeCall call) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Call(
              fromUserId: call.from,
              toUserId: call.to,
              showIncomingUi: true,
              incomingCall: call)),
    );
  }

//endregion
}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFormState();
  }
}

class _MyFormState extends State<MyForm> {
  String strUserId = "";

  @override
  Widget build(BuildContext context) {
    return new Form(
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
                    child: Text('CALL'),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _changeText(String val) {
    setState(() {
      strUserId = val;
    });
  }

  void _voiceCallTapped() {
    if (strUserId.isEmpty || !client.hasConnected) return;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Call(
              fromUserId: client.userId,
              toUserId: strUserId,
              showIncomingUi: false)),
    );
  }
}
