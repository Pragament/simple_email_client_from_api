import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@riverpod
class LoginStateNotifier extends _$LoginStateNotifier {
  late Box _box;
  static const String _loginStateKey = 'login_state';

  @override
  Map<dynamic, dynamic>? build() {
    _box = Hive.box<dynamic>('settingsBox');
    return _box.get(_loginStateKey);
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    var value = {'isLoggedIn': isLoggedIn, 'timeStamp': DateTime.now()};
    await _box.put(_loginStateKey, value);
    state = value;
  }
}
