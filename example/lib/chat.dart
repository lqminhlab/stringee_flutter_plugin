import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';

StringeeChat _stringeeChat = StringeeChat();

class Chat extends StatefulWidget {
  final String toUserId;
  final String fromUserId;
  final StringeeChat stringeeChat;

  Chat(
      {Key key,
      @required this.fromUserId,
      @required this.toUserId,
      @required this.stringeeChat})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  void initState(){
    super.initState();
    init();
  }

  init() async{
    // Map<dynamic, dynamic> rs = await _stringeeChat.createConversation(StringeeConversationType.chat, [widget.toUserId]);
    // print('-----Create conversation------');
    // print(rs);
    // {message: conv-vn-1-0GMF7VCFGZ-1602010962467, status: true, code: 0}
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }

  bool loading = true;
  String message = "";
  //id after create on init function
  String conversationId = "conv-vn-1-0GMF7VCFGZ-1602010962467";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.toUserId), centerTitle: true,),
      body: loading ? Center(child: CircularProgressIndicator(),) : _buildBody(),
    );
  }

  Widget _buildBody(){
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: getMessages(),
            builder: (context, snapData){
              print('----Data get message----');
              print(snapData?.data);
              return Center(child: Text("Message"),);
            },
          ),
        ),
        Row(
          children: [Expanded(
            child: TextFormField(
              onChanged: (val){
                message = val;
              },
            ),
          ), IconButton(icon: Icon(Icons.send), onPressed: _sendMessage,)],
        )
      ],
    );
  }

  Future<dynamic> getMessages()async{
    return await _stringeeChat.getMessages(conversationId);
  }

  _sendMessage(){

  }
}
