import 'package:flutter/material.dart';

class SportsListPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SportsListPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports List"),
      ),
      body: Center(
        child: Text("Sports List"),
      ),
    );
  }
}
