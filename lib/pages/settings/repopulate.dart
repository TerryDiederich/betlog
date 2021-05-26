import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:betlog/providers/sportbook_provider.dart';
import 'package:betlog/providers/team_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepopulatePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => RepopulatePage(),
      );

  @override
  _RepopulatePageState createState() => _RepopulatePageState();
}

class _RepopulatePageState extends State<RepopulatePage> {
  String _statusMessage = 'Press Start to reset data';
  void _process() async {
    final sportsbookProvider = getIt<SportsbookProvider>();
    final sportsProvider = getIt<SportProvider>();
    final teamProvider = getIt<TeamProvider>();

    setState(() {
      _statusMessage = 'Processing Sportsbooks...';
    });

    await sportsbookProvider.removeAllSportsbooks();
    await sportsbookProvider.repopulate();

    setState(() {
      _statusMessage = 'Processing Sports...';
    });

    await sportsProvider.removeAllSports();
    await sportsProvider.repopulate();

    setState(() {
      _statusMessage = 'Processing Teams...';
    });

    await teamProvider.removeAllTeams();
    await teamProvider.repopulate();

    setState(() {
      _statusMessage = 'Finshed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repopulate Tables'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_statusMessage'),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _process(),
              child: Text('Start'),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
