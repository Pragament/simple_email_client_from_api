import 'package:pragament_mail/data/graphql/graphql_requests.dart';
import 'package:pragament_mail/data/models/email_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emails_provider.g.dart';

@riverpod
class EmailsNotifier extends _$EmailsNotifier {
  @override
  List<Email>? build() => null;

  Future load() async {
    final mails = await GraphQLRequests('0')
        .getEmailsByAccountId('672dd786df3538ca2286bd1f');
    if (mails != null) {
      state = [...mails];
    }
  }

  Email getEmailById(String emailId) =>
      state!.firstWhere((element) => element.id == emailId);
}
