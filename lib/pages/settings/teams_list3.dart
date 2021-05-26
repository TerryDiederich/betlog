import 'package:betlog/models/sport.dart';
import 'package:betlog/models/team.dart';
import 'package:betlog/pages/settings/teams_detail.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:betlog/providers/team_provider.dart';
import 'package:flutter/material.dart';

class TeamsList3Page extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => TeamsList3Page(),
      );

  @override
  _TeamsList3PageState createState() => _TeamsList3PageState();
}

class _TeamsList3PageState extends State<TeamsList3Page> {
  String? _selectedSport;

  Future<List<DropdownMenuItem<String>>> sportList() async {
    final sportProvider = getIt<SportProvider>();

    List<Sport?> list = await sportProvider.sportsList;
    List<DropdownMenuItem<String>> items = [];
    for (var sport in list) {
      items.add(
        new DropdownMenuItem(
          value: sport!.name,
          child: Text(sport.name),
        ),
      );
    }
    if (_selectedSport == null) {
      print('SelectedSport is null');
      _selectedSport = items[0].value.toString();
      await _getTeams();
    }
    return items;
  }

  void _setSport(value) {
    setState(() {
      _selectedSport = value.toString();
    });
  }

  DataRow buildDataRow(Team? data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(data!.name)),
        DataCell(Text(data.abbrev)),
        DataCell(
          Icon(Icons.edit),
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => TeamsDetailPage(
                      team: data,
                    ),
                  ),
                )
                .then((value) => setState(() {
                      _selectedSport = _selectedSport;
                    }));
          },
        ),
        DataCell(Icon(Icons.delete)),
      ],
    );
  }

  buildDataColumns() {
    List columns = <DataColumn>[
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Abbrev')),
      DataColumn(label: Text('')),
      DataColumn(label: Text('')),
    ];
    return columns;
  }

  Future<List<Team?>> _getTeams() async {
    final teamProvider = getIt<TeamProvider>();
    print('inside getteams');
    print('$_selectedSport');
    teamProvider.getTeamsList(_selectedSport == null ? '' : _selectedSport!);
    return await teamProvider
        .getTeamsList(_selectedSport == null ? '' : _selectedSport!);
  }

  @override
  Widget build(BuildContext context) {
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
          FutureBuilder<List<Team?>>(
            future: _getTeams(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                print('no date');
                return CircularProgressIndicator();
              } else {
                print(snapshot.data!.length);
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 30,
                    rows: <DataRow>[
                      for (int i = 0; i < snapshot.data!.length; i++)
                        buildDataRow(snapshot.data![i]),
                    ],
                    columns: buildDataColumns(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => TeamsDetailPage(
                    team: Team.empty(),
                  ),
                ),
              )
              .then((value) => setState(() {
                    _selectedSport = _selectedSport;
                  }));
        },
      ),
    );
  }
}


// DataTable
//https://stackoverflow.com/questions/50733005/filling-a-datatable-with-firestore-and-flutter-using-streambuilder

//https://stackoverflow.com/questions/63978409/populate-a-flutter-datatable-with-data-from-firestore-using-a-streambuilder