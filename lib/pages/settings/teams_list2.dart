import 'package:betlog/models/sport.dart';
import 'package:betlog/models/team.dart';
import 'package:betlog/pages/settings/teams_detail.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:betlog/providers/team_provider.dart';
import 'package:flutter/material.dart';

class TeamsList2Page extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => TeamsList2Page(),
      );

  @override
  _TeamsList2PageState createState() => _TeamsList2PageState();
}

class _TeamsList2PageState extends State<TeamsList2Page> {
  String? _selectedSport;

  Future<List<DropdownMenuItem<String>>> sportList() async {
    final sportProvider = getIt<SportProvider>();

    List<Sport?> list = await sportProvider.sportsList;
    List<DropdownMenuItem<String>> items = [];
    for (var sport in list) {
      items.add(
          new DropdownMenuItem(value: sport!.name, child: Text(sport.name)));
    }
    if (_selectedSport == null) {
      _selectedSport = items[0].value.toString();
    }
    return items;
  }

  void _setSport(value) {
    setState(() {
      _selectedSport = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final teamProvider = getIt<TeamProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: FutureBuilder(
                future: sportList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<DropdownMenuItem<String>> sportList =
                        snapshot.data as List<DropdownMenuItem<String>>;
                    return DropdownButton<String>(
                      value: _selectedSport,
                      items: sportList,
                      onChanged: (value) => _setSport(value),
                    );
                  }
                }),
          ),
          SizedBox(
            height: 8.0,
          ),
          StreamBuilder<List<Team>>(
            stream: teamProvider
                .getTeams(_selectedSport == null ? '' : _selectedSport!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return const Text('Firestore is loading...');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(item.name),
                        onDismissed: (direction) {
                          teamProvider.removeTeam(item.teamID);
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
                                builder: (context) => TeamsDetailPage(
                                  team: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


// DataTable
//https://stackoverflow.com/questions/50733005/filling-a-datatable-with-firestore-and-flutter-using-streambuilder

//https://stackoverflow.com/questions/63978409/populate-a-flutter-datatable-with-data-from-firestore-using-a-streambuilder