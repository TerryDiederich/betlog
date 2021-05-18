/// lib/presentation/product_detail/pages/product_detail_page.dart
import 'package:flutter/material.dart';

class SettingsDetailPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SettingsDetailPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Detail"),
      ),
      body: Center(
        child: Text("Settings Detail"),
      ),
    );
  }
}
