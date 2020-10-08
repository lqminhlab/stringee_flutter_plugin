class StringeeUser {
  String userId;
  String name;
  String avatarUrl;
  String role;

  StringeeUser({this.userId, this.name, this.avatarUrl, this.role});

  factory StringeeUser.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return StringeeUser(
        name: json['name'],
        avatarUrl: json['avatarUrl'],
        role: json['role'],
        userId: json['userId']);
  }

  static List<StringeeUser> listFromJson(dynamic listJson) => listJson != null
      ? List<StringeeUser>.from(listJson.map((x) => StringeeUser.fromJson(x)))
      : [];
}
