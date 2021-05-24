import 'package:betlog/models/team.dart';
import 'package:flutter/material.dart';

class TeamsDetailPage extends StatefulWidget {
  final Team team;

  TeamsDetailPage({required this.team});

  @override
  _TeamsDetailPageState createState() => _TeamsDetailPageState();
}

class _TeamsDetailPageState extends State<TeamsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
      ),
      body: Center(
        child: Text(widget.team.sport),
      ),
    );
  }
}
