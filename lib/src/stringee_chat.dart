import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:stringee_flutter_plugin/src/model/conversation.dart';
import 'package:stringee_flutter_plugin/src/model/message.dart';
import 'package:toast/toast.dart';

import 'stringee_client.dart';

enum StringeeConversationType { chat, group }

enum StringeeMessageType { text, picture, audio }

class StringeeChat {
  String _conversationId;
  String _from;
  String _to;
  String _fromAlias;
  String _toAlias;

  String get id => _conversationId;

  String get from => _from;

  String get to => _to;

  String get fromAlias => _fromAlias;

  String get toAlias => _toAlias;

  StringeeChat();

  void initFromInfo(Map<dynamic, dynamic> callInfo) {
    this._conversationId = callInfo['_conversationId'];
    this._from = callInfo['from'];
    this._to = callInfo['to'];
    this._fromAlias = callInfo['fromAlias'];
    this._toAlias = callInfo['toAlias'];
  }

  //region Actions

  //=====================================================================
  //Conversation
  Future<bool> createConversation(
      StringeeConversationType type, List<String> userIds) async {
    Map params;
    bool status = false;
    if (type == StringeeConversationType.chat) {
      params = {"userId": userIds.first};
      final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
          .invokeMethod("createConversationChat", params);
      status = result['status'] ?? false;
    } else if (type == StringeeConversationType.group) {
      params = {"userIds": userIds};
      final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
          .invokeMethod("createConversationGroup", params);
      if (result != null) status = result['status'] ?? false;
    }
    return status;
  }

  Future<List<Conversation>> getConversations(BuildContext context,
      {int count = 20}) async {
    Map params;
    List<Conversation> conversations = [];
    try {
      if (count != null) {
        params = {"count": count};
      }
      Map<dynamic, dynamic> result = await StringeeClient.methodChannel
          .invokeMethod("getConversations", params);
      if (result != null &&
          (result['status'] ?? false) &&
          result['conversations'] != null) {
        conversations =
            Conversation.listFromJson(jsonDecode(result['conversations']));
      }
      Toast.show(result['conversations'] ?? "Gett conversation null!", context,
          duration: 10);
    } catch (e) {
      Toast.show("Gett conversations error: $e!", context, duration: 10);
    }
    return conversations;
  }

  Future<bool> deleteConversation(String conversationId) async {
    Map params;
    bool status = false;
    if (conversationId != null) {
      params = {"conversationId": conversationId};
      final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
          .invokeMethod("deleteConversation", params);
      if (result != null) status = result['status'] ?? false;
    }
    return status;
  }

  //=====================================================================
  //Message
  Future<bool> sendMessage(
      StringeeMessageType type, String conversationId, {String message, File file}) async {
    Map params;
    bool status = false;
    if(conversationId != null) return status;
    switch(type){
      case StringeeMessageType.text:
        params = {"conversationId": conversationId, "message": message};
        final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
            .invokeMethod("sendMessageText", params);
        if (result != null) status = result['status'] ?? false;
        break;
      case StringeeMessageType.audio:
        params = {"conversationId": conversationId, "file": file?.path};
        final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
            .invokeMethod("sendMessagePicture", params);
        if (result != null) status = result['status'] ?? false;
        break;
      case StringeeMessageType.picture:
        params = {"conversationId": conversationId, "file": file?.path};
        final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
            .invokeMethod("sendMessageAudio", params);
        if (result != null) status = result['status'] ?? false;
        break;
      default:
        print(
          "--Send message need: type != null");
        break;
    }
    return status;
  }

  Future<List<Message>> getMessages(String conversationId, BuildContext context,
      {int count = 20}) async {
    Map params;
    List<Message> messages = [];
    try {
      if (conversationId != null && count != null) {
        params = {"conversationId": conversationId, "count": count};
        final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
            .invokeMethod("getMessageFormStringee", params);
        if (result != null &&
            (result['status'] ?? false) &&
            result['messages'] != null) {
          messages = Message.listFromJson(jsonDecode(result['messages']));
        }
        Toast.show(result['messages'] ?? "Gett messages null!", context,
            duration: 10);
      }
    } catch (e) {
      Toast.show("Gett messages error: $e!", context, duration: 10);
    }
    return messages;
  }

  Future<bool> deleteMessage(String messageId) async {
    Map params;
    bool status = false;
    if (messageId != null) {
      params = {"messageId": messageId};
      final Map<dynamic, dynamic> result = await StringeeClient.methodChannel
          .invokeMethod("deleteMessage", params);
      if (result != null) status = result['status'] ?? false;
    }
    return status;
  }

  void destroy() {}

//endregion

}
