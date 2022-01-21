import 'dart:convert';

import 'package:demoweb/controller/controller_data_provider.dart';
import 'package:demoweb/controller/controller_main_view_index_changer.dart';
import 'package:demoweb/views/web/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';


void main()
{
  runApp(MultiProvider(
    providers:  [
      ChangeNotifierProvider<MainViewIndexChanger>(
        create:(context){
          return MainViewIndexChanger();
        }
      ),
      ChangeNotifierProvider<DataProvider>(
          create:(context){
            return DataProvider();
          }
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  ));
}

class MyApp extends StatefulWidget
{
  _MyApp createState ()=> _MyApp();
}

class _MyApp extends State<MyApp>
{
  final _httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  late Link _link;
  late GraphQLClient client;
  late QueryOptions options;
  late QueryResult result;

  @override
  void initState()  {
    _link = _httpLink;
    client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );

    options = QueryOptions(
      document: gql(readRepositories),
    );

   fetch();

    super.initState();
  }


  Future<void> fetch()
  async {
    client.query(options).then((value){



      value.data!.forEach((key, value) {
        print("key - ${key}");
        print("value - ${value}");
      });

    });

  }
 // const var client = http.Client();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(),
      ),
    );
  }


  String readRepositories = r'''
  query ReadRepositories {
    rockets {
    active
    boosters
    company
    cost_per_launch
    country
  }
  }
''';


}