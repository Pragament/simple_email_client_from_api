import 'package:pragament_mail/data/models/account_model.dart';
import 'package:pragament_mail/data/models/organization_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organization_provider.g.dart';

@riverpod
class OraganizationNotifier extends _$OraganizationNotifier {
  @override
  Organization? build() => null;

  update(Organization? organization) => state = organization;
}
