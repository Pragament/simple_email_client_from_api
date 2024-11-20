import 'package:pragament_mail/data/logic/organization_provider.dart';
import 'package:pragament_mail/data/settings.dart';
import 'package:pragament_mail/data/temp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  String? build() => null;

  Future<void> logout() async {
    ref.read(oraganizationNotifierProvider.notifier).update(null);
    account = null;

    await ref.read(loginStateNotifierProvider.notifier).saveLoginState(false);
  }
}
