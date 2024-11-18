import 'package:pragament_mail/data/models/account_model.dart';
import 'package:pragament_mail/data/models/organization_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organization_account_providers.g.dart';

@riverpod
class OraganizationNotifier extends _$OraganizationNotifier {
  @override
  Organization? build() => null;

  update(Organization? organization) => state = organization;
}

@riverpod
class AccountNotifier extends _$AccountNotifier {
  @override
  Account? build() => null;

  update(Account? account) => state = account;
}
