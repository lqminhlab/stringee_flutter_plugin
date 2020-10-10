import 'dart:convert';

import 'package:stringee_flutter_plugin/src/model/models.dart';
import 'stringee_user.dart';

class Conversation {
  String id;
  String creator;
  String name;
  List<StringeeUser> participants;
  int timeCreated;
  Message lastMessage;
  int state;
  int unread;

  Conversation(
      {this.name,
      this.state,
      this.id,
      this.creator,
      this.lastMessage,
      this.participants,
      this.timeCreated,
      this.unread});

  factory Conversation.fromJson(dynamic json) {
    if (json == null) return null;
    if(!json is Map) json = jsonDecode(json);
    return Conversation(
        id: json['id']?.toString(),
        name: json['name']?.toString(),
        creator: json['creator']?.toString(),
        lastMessage: Message.fromJson(json['lastMessage']),
        participants: json['participants'] != null
            ? StringeeUser.listFromJson(json['participants'])
            : [],
        state: json['state'],
        timeCreated: json['timeCreated'],
        unread: json['unread']);
  }

  static List<Conversation> listFromJson(dynamic listJson) => listJson != null
      ? List<Conversation>.from(listJson.map((x) => Conversation.fromJson(x)))
      : [];

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = this.id;
    map["creator"] = this.creator;
    map["name"] = this.name;
    map["lastMessage"] = this.lastMessage;
    map["state"] = this.state;
    map["timeCreated"] = this.timeCreated;
    return map;
  }
}
