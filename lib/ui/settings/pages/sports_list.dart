import 'package:betlog/models/sport.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:betlog/ui/settings/pages/sports_entry.dart';
import 'package:flutter/material.dart';

class SportsListPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SportsListPage(),
      );
  final sportProvider = getIt<SportProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports List"),
      ),
      body: StreamBuilder<List<Sport>>(
          stream: sportProvider.sports,
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
                        sportProvider.remoteSport(item.sportID);
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
                              builder: (context) => SportsEntry(
                                sport: snapshot.data?[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SportsEntry()));
        },
      ),
    );
  }
}
