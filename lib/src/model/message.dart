import 'dart:convert';

/// conversation : "conv-vn-1-0GMF7VCFGZ-1602010962467"
/// creator : "lab_user01"
/// id : "msg-vn-1-0GMF7VCFGZ-1602011212701"
/// message : "{}"
/// state : "SENT"
/// timeCreated : 0

class Message {
  int _type;
  String _conversation;
  String _creator;
  String _id;
  String _message;
  String _state;
  int _timeCreated;

  int get type => _type;

  String get conversation => _conversation;

  String get creator => _creator;

  String get id => _id;

  String get message => _message;

  String get state => _state;

  int get timeCreated => _timeCreated;

  Message(
      {String conversation,
      String creator,
      String id,
        int type,
      String message,
      String state,
      int timeCreated}) {
    _conversation = conversation;
    _creator = creator;
    _id = id;
    _type = type;
    _message = message;
    _state = state;
    _timeCreated = timeCreated;
  }

  Message.fromJson(dynamic json) {
    try {
      if (json == null) return;
      _conversation = json["c"];
      _creator = json["z"];
      _id = json["a"];
      _message = json["l"];
      _state = json["i"];
      _timeCreated = json["g"];
      _type = json['k'];
    } catch (e) {
      print('--error map message:$e');
      return;
    }
  }

  static List<Message> listFromJson(dynamic listJson) => listJson != null
      ? List<Message>.from(listJson.map((x) => Message.fromJson(x)))
      : [];

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["conversation"] = _conversation;
    map["creator"] = _creator;
    map["id"] = _id;
    map["message"] = _message;
    map["state"] = _state;
    map['type'] = _type;
    map["timeCreated"] = _timeCreated;
    return map;
  }
}
