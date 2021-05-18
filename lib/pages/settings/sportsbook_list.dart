import 'package:flutter/material.dart';

class SportsbookListPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SportsbookListPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sportsbook List'),
      ),
      body: Text('Sportsbooks'),
    );
  }
}
