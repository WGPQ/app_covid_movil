import 'package:app_covid19/view/home.dart';
import 'package:app_covid19/view/splashScreen.dart';
import 'package:app_covid19/view/wrongpage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'model/provincia.dart';
import 'package:date_format/date_format.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink(uri: 'http://localhost:3000/');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
            GraphQLClient(link: httpLink, cache: InMemoryCache()));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Covid 19',
          theme: ThemeData(primarySwatch: Colors.purple),
          home: HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Provincia> _provincia = [];
  DateTime now = new DateTime.now();
  String query = r"""
query casos($fecha: Date){
  provincia{
    id
    nombre
    imageurl
    casos(fecha:$fecha){
      id
      fallecidos
      recuperados
      confirmados
      fecha
    }
  }
}""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Query(
            options: QueryOptions(
                documentNode: gql(query),
                variables: <String, dynamic>{"fecha": currenti_date()}),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return FailPage();
              }

              if (result.loading) {
                return SplashScream();
              }
              List list_prov = result.data["provincia"];
              _provincia = (list_prov)
                  .map<Provincia>((item) => Provincia.fromJson(item))
                  .toList();
              return ViewHome(provncia: _provincia, provcasos: list_prov);
            }));
  }

  String currenti_date() {
    var fecha = formatDate(
        DateTime(now.year, now.month, now.day), [yyyy, '-', mm, '-', dd]);
    return fecha;
  }
}
