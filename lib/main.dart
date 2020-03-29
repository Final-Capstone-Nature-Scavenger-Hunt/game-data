import 'package:flutter/material.dart';
import 'package:game/database.dart';
import 'package:game/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}


class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  final List<String> difficultylevels = ["Easy", "Hard", "Med"];
  String currentLevel;
  String currentSpecies;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Hunt>>(
      stream: Database( level : currentLevel ?? "Easy").hunt,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<Hunt> huntData = snapshot.data;
          return Scaffold(
              appBar: AppBar(title: Text('Hello')),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical:10) ,
            child: Column(
              children: <Widget>[
                DropdownButtonFormField(
                value : currentLevel ?? "Easy",
                items: difficultylevels.map( (level) =>
                  DropdownMenuItem(
                    child: Text(level),
                    value: level
                    )
                ).toList(),
                onChanged : (level) => setState(()=> currentLevel = level )
                ),
                Container(
                  child: DropdownButtonFormField(
                    value: currentSpecies,
                    items: huntData.map((hunt) {
                      print(hunt.huntName);
                      return DropdownMenuItem(
                        child: Text(hunt.huntName),
                        value: hunt.huntName
                      );
                    }
                    ).toList(),
                    onChanged: (species) => setState(()=> currentSpecies = species),
                    ),
                  )
              ],
            )
          ),
        );
        }
        else{
          return Container(
            child: Text('nothing')
          );
        }
      }
    );
  }
}

