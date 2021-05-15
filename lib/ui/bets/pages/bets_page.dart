import 'package:betlog/data/database.dart';
import 'package:betlog/models/sport.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BetsPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BetsPage(),
      );

  _getData() async {
    Database db = Database();
    var uuid = Uuid();
    // var sport = Sport(
    //   sportID: uuid.v1(),
    //   name: 'NFL',
    //   sortOrder: 3,
    // );
    // db.setSport(sport);
    List<Sport?> list = [];
    list = await db.getSportsList();
    if (list != null) {
      var cnt = list.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bets"),
      ),
      body: Center(
        // child: Text("List of bets"),
        child: TextButton(
          onPressed: () => _getData(),
          child: Text("Get Data"),
        ),
      ),
    );
  }
}
