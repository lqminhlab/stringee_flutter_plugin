import 'dart:async';

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
  bool loading = true;
  TextEditingController controller = TextEditingController();
  Conversation conversation;
  Timer timer;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  init() async {
    conversation = await getOrCreateConversation(id: widget.toUserId);
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) setState(() {});
    });
    setState(() {
      loading = false;
    });
  }

  Future<Conversation> getOrCreateConversation({String id}) async {
    List<Conversation> conversations =
        await _stringeeChat.getConversations(count: 100);
    for (Conversation conversation in conversations) {
      for (StringeeUser user in conversation?.participants ?? []) {
        if (user.userId == id) {
          return conversation;
        }
      }
    }
    await _stringeeChat.createConversation(StringeeConversationType.chat, [id]);
    return await getOrCreateConversation(id: id);
  }

  Future<List<Message>> getMessages() async {
    return await _stringeeChat.getMessages(conversation.id);
  }

  _sendMessage() async {
    final rs = await _stringeeChat.sendMessage(
        StringeeMessageType.text, conversation.id,
        message: controller.text);
    controller.clear();
    print('----Data send message----');
    print(rs?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toUserId),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Message>>(
            future: getMessages(),
            builder: (context, snapData) {
              if (snapData.connectionState == ConnectionState.done) {
                print('----Data get message----');
                print(snapData?.data);
                List<Message> messages = snapData?.data ?? [];
                return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) =>
                        buildMessage(messages[index]));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: (val) {
                  _sendMessage();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            )
          ],
        )
      ],
    );
  }

  Widget buildMessage(Message message) {
    return Row(
      children: [Text(message.message ?? "Message null")],
    );
  }
}
