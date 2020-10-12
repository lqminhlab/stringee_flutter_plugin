import 'dart:convert';

class StringeeUser {
  String userId;
  String name;
  String avatarUrl;
  String role;

  StringeeUser({this.userId, this.name, this.avatarUrl, this.role});

  factory StringeeUser.fromJson(dynamic json) {
    try {
      if (json == null) return null;
      // if (!(json is Map)) json = jsonDecode(json);
      return StringeeUser(
          name: json['name'],
          avatarUrl: json['avatarUrl'],
          role: json['role'],
          userId: json['userId']);
    } catch (e) {
      print('--error map user:$e');
      return null;
    }
  }

  static List<StringeeUser> listFromJson(dynamic listJson) => listJson != null
      ? List<StringeeUser>.from(listJson.map((x) => StringeeUser.fromJson(x)))
      : [];
}
