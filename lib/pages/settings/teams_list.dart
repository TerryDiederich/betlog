import 'package:betlog/models/sport.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:flutter/material.dart';

class TeamsListPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => TeamsListPage(),
      );

  @override
  _TeamsListPageState createState() => _TeamsListPageState();
}

class _TeamsListPageState extends State<TeamsListPage> {
  String _selectedSport = '';

  Future<List<DropdownMenuItem<String>>> sportList() async {
    final sportProvider = getIt<SportProvider>();
    List<Sport?> list = await sportProvider.sportsList;
    List<DropdownMenuItem<String>> items = [];
    for (var sport in list) {
      items.add(
          new DropdownMenuItem(value: sport!.name, child: Text(sport.name)));
    }
    _selectedSport = items[0].value.toString();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teams'),
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
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
                      onChanged: (value) {
                        print(value);
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
// Add dropdownbutton
// use sports list to populate
// populate list in initstate, create separate function for async

//https://stackoverflow.com/questions/53555367/flutter-default-value-in-dropdown
// https://yashodgayashan.medium.com/flutter-dropdown-button-widget-469794c886d0
//https://stackoverflow.com/questions/51901002/is-there-a-way-to-load-async-data-on-initstate-method
