import 'package:pragament_mail/data/logic/organization_account_providers.dart';
import 'package:pragament_mail/data/settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  String? build() => null;

  Future<void> logout() async {
    ref.read(oraganizationNotifierProvider.notifier).update(null);
    ref.read(accountNotifierProvider.notifier).update(null);

    await ref.read(loginStateNotifierProvider.notifier).saveLoginState(false);
  }
}
