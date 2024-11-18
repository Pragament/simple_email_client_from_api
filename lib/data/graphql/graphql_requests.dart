import 'package:pragament_mail/data/graphql/graphql_raw.dart';
import 'package:pragament_mail/data/graphql/graphql_service.dart';
import 'package:pragament_mail/data/models/account_model.dart';
import 'package:pragament_mail/data/models/email_model.dart';
import 'package:pragament_mail/data/models/organization_model.dart';
import 'package:pragament_mail/presentation/widgets/my_snackbar.dart';
import 'package:pragament_mail/utils/debug_print.dart';

class GraphQLRequests {
  GraphQLRequests(this.token);

  final String token;

  Future<Account?> createAccount({
    required String orgId,
    required String emailLocalPart,
    required String password,
    required String? secondaryEmailId,
  }) async {
    final response = await GraphQLService(token)
        .performMutation(GraphQLRaw.createAccount, variables: {
      'accountInput': {
        'org_id': orgId,
        'email_local_part': emailLocalPart,
        'password': password,
        'secondary_email_id': secondaryEmailId ?? '',
      }
    });

    if (response.hasException) {
      printInDebug('GraphQL Error: ${response.exception}');
      var errMsg = response.exception!.graphqlErrors[0].message;
      if (errMsg == 'Email already exists within this organization') {
        showSnackBar(message: errMsg);
      }
      return null;
    }

    final Map<String, dynamic>? data = response.data;

    return data != null && data.containsKey('createAccount')
        ? Account.fromMap(data['createAccount'] as Map<String, dynamic>)
        : null;
  }

  Future<Organization?> getOrgById(String orgId) async {
    final response = await GraphQLService(token)
        .performQuery(GraphQLRaw.getOrgById, variables: {'id': orgId});
    printInDebug('Has exeption: ${response.exception}');

    if (response.hasException) {
      printInDebug('GraphQL Error: ${response.exception}');
      return null;
    }

    final Map<String, dynamic>? data = response.data;

    return data != null &&
            data.containsKey('getOrgById') &&
            data['getOrgById'] != null
        ? Organization.fromMap(data['getOrgById'] as Map<String, dynamic>)
        : null;
  }

  Future<Account?> getAccount(String email, String password) async {
    final response = await GraphQLService(token).performQuery(
        GraphQLRaw.getAccount,
        variables: {'email_local_part': email, 'password': password});
    printInDebug('Has exeption: ${response.exception}');

    if (response.hasException) {
      printInDebug('GraphQL Error: ${response.exception}');
      return null;
    }

    final Map<String, dynamic>? data = response.data;

    return data != null &&
            data.containsKey('getAllAccounts') &&
            data['getAllAccounts'].isNotEmpty
        ? Account.fromMap((data['getAllAccounts'] as List<dynamic>).first
            as Map<String, dynamic>)
        : null;
  }

  Future<List<Email>?> getEmailsByAccountId(String accountId) async {
    final response = await GraphQLService(token).performQuery(
        GraphQLRaw.getEmailsByAccountId,
        variables: {'account_id': accountId});
    printInDebug('Has exeption: ${response.exception}');

    if (response.hasException) {
      printInDebug('GraphQL Error: ${response.exception}');
      return null;
    }

    final Map<String, dynamic>? data = response.data;

    return data != null && data.containsKey('getEmailsByAccountId')
        ? (data['getEmailsByAccountId'] as List<dynamic>)
            .map((e) => Email.fromMap(e as Map<String, dynamic>))
            .toList()
        : null;
  }
}
