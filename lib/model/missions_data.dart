import 'package:ferry/ferry.dart';
import 'package:graphql/client.dart';

class MissionData
{
  String name,description,id,manufacturer,website;

  MissionData(
      this.name, this.description, this.id, this.manufacturer, this.website);

}


class FetchMissionData{
  Future<QueryResult> fetchMissionData()
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
      missions {
      name
      description
      id
      manufacturers
      website
    }
  }
''';

  late Link _link;
  late GraphQLClient client;
  late QueryOptions options;
  late QueryResult result;

}
