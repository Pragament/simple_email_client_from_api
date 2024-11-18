class Organization {
  String id;
  String name;
  String emailDomainPart;
  DateTime datetime;
  String emailId;
  String mode;
  String clientApiKey;
  String? userId;

  Organization({
    required this.id,
    required this.name,
    required this.emailDomainPart,
    required this.datetime,
    required this.emailId,
    required this.mode,
    required this.clientApiKey,
    this.userId,
  });

  Organization copyWith({
    String? id,
    String? name,
    String? emailDomainPart,
    DateTime? datetime,
    String? emailId,
    String? mode,
    String? clientApiKey,
    String? userId,
  }) =>
      Organization(
        id: id ?? this.id,
        name: name ?? this.name,
        emailDomainPart: emailDomainPart ?? this.emailDomainPart,
        datetime: datetime ?? this.datetime,
        emailId: emailId ?? this.emailId,
        mode: mode ?? this.mode,
        clientApiKey: clientApiKey ?? this.clientApiKey,
        userId: userId ?? this.userId,
      );

  factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        id: json["id"],
        name: json["name"],
        emailDomainPart: json["email_domain_part"],
        datetime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(json["datetime"])),
        emailId: json["email_id"],
        mode: json["mode"],
        clientApiKey: json["client_api_key"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email_domain_part": emailDomainPart,
        "datetime": datetime.millisecondsSinceEpoch,
        "email_id": emailId,
        "mode": mode,
        "client_api_key": clientApiKey,
        "user_id": userId,
      };
}
