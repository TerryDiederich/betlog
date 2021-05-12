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
        child: TextButton(
          onPressed: () => Navigator.of(context).push(
            SettingsDetailPage.route(),
          ),
          child: Text("Navigate to Settings Detail Page"),
        ),
      ),
    );
  }
}
