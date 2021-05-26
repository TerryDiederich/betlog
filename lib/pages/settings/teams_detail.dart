import 'package:betlog/models/team.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/team_provider.dart';
import 'package:flutter/material.dart';

class TeamsDetailPage extends StatefulWidget {
  final Team team;

  TeamsDetailPage({required this.team});

  @override
  _TeamsDetailPageState createState() => _TeamsDetailPageState();
}

class _TeamsDetailPageState extends State<TeamsDetailPage> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final abbrevController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    abbrevController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final teamProvider = getIt<TeamProvider>();
    nameController.text = widget.team.name;
    abbrevController.text = widget.team.abbrev;
    teamProvider.initializeTeam(widget.team);
    super.initState();
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    if (value.length > 40) {
      return 'Name cannot be greater than 40 characters';
    }
  }

  String? _validateAbbrev(String? value) {
    if (value!.isEmpty) {
      return 'Abbrev is required';
    }
    if (value.length > 4) {
      return 'Abbrev cannot be greater than 4 characters';
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamProvider = getIt<TeamProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Team Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateName(value),
                onChanged: (String value) => teamProvider.changeName = value,
                controller: nameController,
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Abbrev'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateAbbrev(value),
                onChanged: (String value) => teamProvider.changeAbbrev = value,
                controller: abbrevController,
                autofocus: true,
              ),
              ElevatedButton(
                onPressed: () {
                  var form = _formkey.currentState!;
                  if (form.validate()) {
                    teamProvider.saveTeam();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
