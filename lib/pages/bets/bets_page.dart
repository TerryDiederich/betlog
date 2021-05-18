//import 'package:betlog/providers/sport_provider.dart';
//import 'package:betlog/models/sport.dart';
//import 'package:betlog/providers/setup_getit.dart';
import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';

class BetsPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BetsPage(),
      );

  _getData() async {
    //Database db = Database();
    //  final sportProvider = getIt<SportProvider>();
    // var uuid = Uuid();
    // var sport = Sport(
    //   sportID: uuid.v1(),
    //   name: 'NFL',
    //   sortOrder: 3,
    // );
    // db.setSport(sport);
    // List<Sport?> list = [];
    // list = await sportProvider.sportsList;
    // var cnt = list.length;
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
