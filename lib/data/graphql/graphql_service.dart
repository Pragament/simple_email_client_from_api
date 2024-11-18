import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pragament_mail/data/env/env.dart';

String graphqlServerUri =
    kReleaseMode ? Env.GRAPHQL_URI : 'http://192.168.1.105:5006/graphql';

class GraphQLService {
  late GraphQLClient client;

  GraphQLService(String token) {
    final HttpLink httpLink = HttpLink(graphqlServerUri);
    final AuthLink authLink = AuthLink(
      getToken: () => token,
    );
    final Link link = authLink.concat(httpLink);
    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  Future<QueryResult> performQuery(String query,
      {required Map<String, dynamic> variables}) async {
    final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly);
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return result;
  }

  Future<QueryResult> performMutation(String mutation,
      {required Map<String, dynamic> variables}) async {
    final MutationOptions options =
        MutationOptions(document: gql(mutation), variables: variables);
    final QueryResult result = await client.mutate(options);
    // if (result.hasException) {
    //   throw result.exception!;
    // }
    return result;
  }

  // Stream<Response> subscriptionGraphQL(
  //   String query, {
  //   required Map<String, dynamic> variables,
  //   required String operationName,
  // }) async* {
  //   final operation = Operation(
  //     document: gql(query),
  //     operationName: operationName,
  //   );
  //   final Request request = Request(
  //     operation: operation,
  //     variables: variables,
  //   );
  // //  yield* _socketClient.subscribe;
  // }
}
