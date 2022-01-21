import 'package:demoweb/controller/controller_data_provider.dart';
import 'package:graphql/client.dart';

class LaunchPad{
  late String lname;
  late double count;
  late String status;

  LaunchPad(this.lname, this.count, this.status);

  void fetchLaunchPadData()
  {
    _link = _httpLink;
    client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );

    options = QueryOptions(
      document: gql(readRepositories),
    );

    client.query(options).then((value){

      value.data!.forEach((key, value) {
        print("key - ${key}");
        print("value - ${value}");
      });

    });
  }

  final _httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  String readRepositories = r'''
  query ReadRepositories {
    launchpads {
    name
    status
    successful_launches
  }
  }
''';

  late Link _link;
  late GraphQLClient client;
  late QueryOptions options;
  late QueryResult result;

}

class FetchLaunchPad{
  Future<QueryResult> fetchLaunchPadData()
  {
    _link = _httpLink;
    client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
    options = QueryOptions(
      document: gql(readRepositories),
    );

    return client.query(options);
  }

  final _httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  String readRepositories = r'''
  query ReadRepositories {
    launchpads {
    name
    status
    successful_launches
  }
  }
''';

  late Link _link;
  late GraphQLClient client;
  late QueryOptions options;
  late QueryResult result;

}

