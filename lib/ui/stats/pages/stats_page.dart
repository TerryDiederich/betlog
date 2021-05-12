/// lib/presentation/home/pages/home_page.dart
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => StatsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats"),
      ),
      body: Center(
        child: Text("Stats Page"),
      ),
    );
  }
}
