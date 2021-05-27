import 'package:betlog/models/bet.dart';
import 'package:betlog/providers/bet_provider.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BetsPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BetsPage(),
      );

  @override
  _BetsPageState createState() => _BetsPageState();
}

class _BetsPageState extends State<BetsPage> {
  final betProvider = getIt<BetProvider>();

  _getData() async {
    final betProvider = getIt<BetProvider>();

    await betProvider.saveLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bets"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _getData(),
            child: Text('Add Data'),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Open Bets',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          StreamBuilder<List<Bet>>(
            stream: betProvider.bets,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error:' + snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(item.betID),
                        onDismissed: (direction) {},
                        background: Container(
                          color: Colors.red,
                        ),
                        child: _buildListTile(snapshot, index),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  ListTile _buildListTile(AsyncSnapshot<List<Bet>> snapshot, int index) {
    Bet bet = snapshot.data![index];

    if (bet.betType == 'Moneyline') {
      return _buildMoneylineTile(bet);
    } else if (bet.betType == 'Spread') {
      return _buildSpreadTile(bet);
    } else {
      return _buildTotalsTile(bet);
    }
  }

  ListTile _buildMoneylineTile(Bet bet) {
    String title = bet.sportsbook +
        '   ' +
        bet.betTeam +
        ' ' +
        bet.odds.toString() +
        '    ' +
        NumberFormat.simpleCurrency().format(bet.amountBet) +
        ' : ' +
        NumberFormat.simpleCurrency().format(bet.amountToWin);

    DateTime gameDateTime =
        Timestamp.fromMillisecondsSinceEpoch(bet.gamedate).toDate();
    final dateFormatter = DateFormat('MM-dd-yyyy');
    String gameDate = dateFormatter.format(gameDateTime);

    String sub = gameDate +
        '   ' +
        bet.sport +
        '   ' +
        bet.awayTeam +
        ' vs ' +
        bet.homeTeam;
    return ListTile(
      //trailing: Icon(Icons.check),
      title: Text(title),
      subtitle: Text(sub),
      //leading: Icon(Icons.sports_baseball),
    );
  }

  ListTile _buildSpreadTile(Bet bet) {
    String title = bet.sportsbook +
        '   ' +
        bet.betTeam +
        ' ' +
        bet.spread.toString() +
        ' ' +
        bet.odds.toString() +
        '    ' +
        NumberFormat.simpleCurrency().format(bet.amountBet) +
        '-' +
        NumberFormat.simpleCurrency().format(bet.amountToWin);

    DateTime gameDateTime =
        Timestamp.fromMillisecondsSinceEpoch(bet.gamedate).toDate();
    final dateFormatter = DateFormat('MM-dd-yyyy');
    String gameDate = dateFormatter.format(gameDateTime);

    String sub = gameDate +
        '   ' +
        bet.sport +
        '   ' +
        bet.awayTeam +
        ' vs ' +
        bet.homeTeam;
    return ListTile(
      //trailing: Icon(Icons.check),
      title: Text(title),
      subtitle: Text(sub),
      // leading: Icon(Icons.sports_baseball),
    );
  }

  ListTile _buildTotalsTile(Bet bet) {
    String title = bet.sportsbook +
        '   ' +
        bet.total.toString() +
        ' ' +
        bet.overunder +
        ' ' +
        bet.odds.toString() +
        '    ' +
        NumberFormat.simpleCurrency().format(bet.amountBet) +
        '-' +
        NumberFormat.simpleCurrency().format(bet.amountToWin);

    DateTime gameDateTime =
        Timestamp.fromMillisecondsSinceEpoch(bet.gamedate).toDate();
    final dateFormatter = DateFormat('MM-dd-yyyy');
    String gameDate = dateFormatter.format(gameDateTime);

    String sub = gameDate +
        '   ' +
        bet.sport +
        '   ' +
        bet.awayTeam +
        ' vs ' +
        bet.homeTeam;
    return ListTile(
      //trailing: Icon(Icons.check),
      title: Text(title),
      subtitle: Text(sub),
      // leading: Icon(Icons.sports_baseball),
    );
  }
}
