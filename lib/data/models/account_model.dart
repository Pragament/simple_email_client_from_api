class Account {
  String id;
  String orgId;
  String? emailLocalPart;
  String? password;
  DateTime? datetime;
  String secondaryEmailId;
  String? authorUserId;

  Account({
    required this.id,
    required this.orgId,
    required this.emailLocalPart,
    required this.password,
    required this.datetime,
    required this.secondaryEmailId,
    required this.authorUserId,
  });

  Account copyWith({
    String? id,
    String? orgId,
    String? emailLocalPart,
    String? password,
    DateTime? datetime,
    String? secondaryEmailId,
    String? authorUserId,
  }) =>
      Account(
        id: id ?? this.id,
        orgId: orgId ?? this.orgId,
        emailLocalPart: emailLocalPart ?? this.emailLocalPart,
        password: password ?? this.password,
        datetime: datetime ?? this.datetime,
        secondaryEmailId: secondaryEmailId ?? this.secondaryEmailId,
        authorUserId: authorUserId ?? this.authorUserId,
      );

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        orgId: json["org_id"],
        emailLocalPart: json["email_local_part"],
        password: json["password"],
        datetime: json["datetime"] != null
            ? DateTime.fromMillisecondsSinceEpoch(int.parse(json["datetime"]))
            : null,
        secondaryEmailId: json["secondary_email_id"],
        authorUserId: json["author_user_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "org_id": orgId,
        "email_local_part": emailLocalPart,
        "password": password,
        "datetime": datetime?.millisecondsSinceEpoch,
        "secondary_email_id": secondaryEmailId,
        "author_user_id": authorUserId,
      };
}
