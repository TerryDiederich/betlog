import 'package:betlog/models/bet.dart';
import 'package:betlog/providers/bet_provider.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:flutter/material.dart';

class BetsPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BetsPage(),
      );

  @override
  _BetsPageState createState() => _BetsPageState();
}

class _BetsPageState extends State<BetsPage> {
  final betProvider = getIt<BetProvider>();

  //_getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bets"),
      ),
      body: Column(
        children: [
          Text(
            'Open Bets',
            textAlign: TextAlign.center,
          ),
          StreamBuilder<List<Bet>>(
            stream: betProvider.bets,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
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
                      child: ListTile(
                        trailing: Icon(Icons.add),
                        title: Text(snapshot.data![index].odds.toString()),
                        subtitle: Text(snapshot.data![index].homeTeam),
                        leading: Icon(Icons.sports_baseball),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
