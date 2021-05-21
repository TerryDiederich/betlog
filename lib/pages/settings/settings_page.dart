import 'package:betlog/pages/settings/sports_list.dart';
import 'package:betlog/pages/settings/sportsbook_list.dart';
import 'package:betlog/pages/settings/teams_list.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                  SportsListPage.route(),
                ),
                child: Text("Edit Sports"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                  SportsbookListPage.route(),
                ),
                child: Text("Edit Sportsbooks"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                  TeamsListPage.route(),
                ),
                child: Text("Edit Teams"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );
}
