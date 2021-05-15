import 'package:betlog/ui/settings/pages/sports_list.dart';

/// lib/presentation/shop/pages/shop_page.dart

import 'package:flutter/material.dart';
import 'package:betlog/ui/settings/pages/settings_detail_page.dart';

class SettingsPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );

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
                  SettingsDetailPage.route(),
                ),
                child: Text("Navigate to Settings Detail Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
