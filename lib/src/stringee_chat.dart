import 'dart:async';

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
  Future<Map<dynamic, dynamic>> createConversation(
      StringeeConversationType type, List<String> userIds) async {
    Map params;
    if (type == StringeeConversationType.chat) {
      params = {"userId": userIds.first};
      return await StringeeClient.methodChannel
          .invokeMethod("createConversationChat", params);
    } else if (type == StringeeConversationType.group) {
      params = {"userIds": userIds};
      return await StringeeClient.methodChannel
          .invokeMethod("createConversationGroup", params);
    } else {
      return throw NullThrownError();
    }
  }

  Future<Map<dynamic, dynamic>> getConversations({int count = 20}) async {
    Map params;
    if (count != null) {
      params = {"count": count};
      return await StringeeClient.methodChannel
          .invokeMethod("getConversations", params);
    } else {
      return throw NullThrownError();
    }
  }

  Future<Map<dynamic, dynamic>> deleteConversation(
      String conversationId) async {
    Map params;
    if (conversationId != null) {
      params = {"conversationId": conversationId};
      return await StringeeClient.methodChannel
          .invokeMethod("deleteConversation", params);
    } else {
      return throw NullThrownError();
    }
  }

  //=====================================================================
  //Message
  Future<Map<dynamic, dynamic>> sendMessage(StringeeMessageType type,
      String conversationId, String message) async {
    Map params;
    if (conversationId != null && message != null && type != null) {
      params = {"conversationId": conversationId, "message": message};
      return await StringeeClient.methodChannel
          .invokeMethod("sendMessageText", params);
    } else {
      return throw NullThrownError();
    }
  }

  Future<Map<dynamic, dynamic>> getMessages(String conversationId,
      {int count = 20}) async {
    Map params;
    if (conversationId != null && count != null) {
      params = {"conversationId": conversationId, "count": count};
      return await StringeeClient.methodChannel
          .invokeMethod("getMessageFormStringee", params);
    } else {
      return throw NullThrownError();
    }
  }
  Future<Map<dynamic, dynamic>> deleteMessage(
      String messageId) async {
    Map params;
    if (messageId != null) {
      params = {"messageId": messageId};
      return await StringeeClient.methodChannel
          .invokeMethod("deleteMessage", params);
    } else {
      return throw NullThrownError();
    }
  }


  void destroy() {}

//endregion

}
