class Email {
  String id;
  String toAccountId;
  String toName;
  String toEmail;
  String fromName;
  String fromEmail;
  String subject;
  String body;
  bool isHtml;
  DateTime datetime;
  String orgId;
  String? authorUserId;

  Email({
    required this.id,
    required this.toAccountId,
    required this.toName,
    required this.toEmail,
    required this.fromName,
    required this.fromEmail,
    required this.subject,
    required this.body,
    required this.isHtml,
    required this.datetime,
    required this.orgId,
    required this.authorUserId,
  });

  Email copyWith({
    String? id,
    String? toAccountId,
    String? toName,
    String? toEmail,
    String? fromName,
    String? fromEmail,
    String? subject,
    String? body,
    bool? isHtml,
    DateTime? datetime,
    String? orgId,
    String? authorUserId,
  }) =>
      Email(
        id: id ?? this.id,
        toAccountId: toAccountId ?? this.toAccountId,
        toName: toName ?? this.toEmail,
        toEmail: toEmail ?? this.toEmail,
        fromName: fromName ?? this.fromName,
        fromEmail: fromEmail ?? this.fromEmail,
        subject: subject ?? this.subject,
        body: body ?? this.body,
        isHtml: isHtml ?? this.isHtml,
        datetime: datetime ?? this.datetime,
        orgId: orgId ?? this.orgId,
        authorUserId: authorUserId ?? this.authorUserId,
      );

  factory Email.fromMap(Map<String, dynamic> json) => Email(
        id: json["id"],
        toAccountId: json["to_account_id"],
        toName: json["to_name"],
        toEmail: json["to_email"],
        fromName: json["from_name"],
        fromEmail: json["from_email"],
        subject: json["subject"],
        body: json["body"],
        isHtml: json["is_html"],
        datetime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(json["datetime"])),
        orgId: json["org_id"],
        authorUserId: json["author_user_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "to_account_id": toAccountId,
        "to_name": toName,
        "to_email": toEmail,
        "from_name": fromName,
        "from_email": fromEmail,
        "subject": subject,
        "body": body,
        "is_html": isHtml,
        "datetime": datetime.millisecondsSinceEpoch,
        "org_id": orgId,
        "author_user_id": authorUserId,
      };
}
