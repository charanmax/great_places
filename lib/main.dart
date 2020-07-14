import 'package:flutter/material.dart';
import './Widgets/AddPlace.dart';
import 'package:provider/provider.dart';
import 'Providers/Places_List.dart';
import 'Widgets/ShowPlaces.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Places(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: GreatPlaces(),
        routes: {
          AddPlace.id: (ctx) => AddPlace(),
        },
      ),
    );
  }
}

class GreatPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlace.id);
            },
          ),
        ],
      ),
      drawer: Drawer(),
      body: ShowPlaces(),
    );
  }
}
