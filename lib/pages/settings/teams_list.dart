import 'package:flutter/material.dart';

class TeamsListPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => TeamsListPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teams'),
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
// Add dropdownbutton 
// use sports list to populate
// populate list in initstate, create separate function for async


//https://stackoverflow.com/questions/53555367/flutter-default-value-in-dropdown
// https://yashodgayashan.medium.com/flutter-dropdown-button-widget-469794c886d0
//https://stackoverflow.com/questions/51901002/is-there-a-way-to-load-async-data-on-initstate-method