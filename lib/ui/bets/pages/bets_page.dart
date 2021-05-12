import 'package:flutter/material.dart';

class BetsPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BetsPage(),
      );

  _getData() async {}

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
