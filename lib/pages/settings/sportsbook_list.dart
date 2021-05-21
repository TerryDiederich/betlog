import 'package:betlog/models/sportsbook.dart';
import 'package:betlog/pages/settings/sportsbook_detail.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sportbook_provider.dart';
import 'package:flutter/material.dart';

class SportsbookListPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SportsbookListPage(),
      );

  final sportsbookProvider = getIt<SportsbookProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sportsbook List'),
      ),
      body: StreamBuilder<List<Sportsbook>>(
        stream: sportsbookProvider.sportsbooks,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Firestore had an error');
          }
          if (!snapshot.hasData) {
            return const Text('Firestore is loading...');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(item.name),
                  onDismissed: (direction) {
                    sportsbookProvider.removeSportsbook(item.sportsbookID);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${item.name} deleted',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    trailing: Icon(
                      Icons.edit,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(snapshot.data![index].name),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SportsbookDetail(
                            sportsbook: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SportsbookDetail(
                sportsbook: Sportsbook.empty(),
              ),
            ),
          );
        },
      ),
    );
  }
}
