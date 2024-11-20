import 'package:pragament_mail/data/graphql/graphql_requests.dart';
import 'package:pragament_mail/data/logic/auth_provider.dart';
import 'package:pragament_mail/data/models/email_model.dart';
import 'package:pragament_mail/data/temp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emails_provider.g.dart';

@riverpod
class Emails extends _$Emails {
  @override
  List<Email>? build() => null;

  Future load() async {
    if (account == null) {
      await Future.delayed(const Duration(milliseconds: 250));
      await ref.read(userNotifierProvider.notifier).logout();
      return;
    }
    final mails = await GraphQLRequests('0').getEmailsByAccountId(account!.id);
    if (mails != null) {
      state = mails;
    }
  }

  Email getEmailById(String emailId) =>
      state!.firstWhere((element) => element.id == emailId);
}
