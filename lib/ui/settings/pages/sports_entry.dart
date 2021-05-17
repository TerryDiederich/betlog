import 'package:betlog/models/sport.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sport_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SportsEntry extends StatefulWidget {
  final Sport sport;

  SportsEntry({required this.sport});

  @override
  _SportsEntryState createState() => _SportsEntryState();
}

class _SportsEntryState extends State<SportsEntry> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final sortOrderController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    sortOrderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final sportProvider = getIt<SportProvider>();
    nameController.text = widget.sport.name;
    sortOrderController.text = widget.sport.sortOrder.toString();
    sportProvider.initializeSport(widget.sport);

    // if (widget.sport.sportID == '') {
    //   nameController.text = widget.sport.name;
    //   sortOrderController.text = widget.sport.sortOrder.toString();
    //   sportProvider.initializeSport(widget.sport);
    //   //edit
    // } else {
    //   //add
    //   sportProvider.initializeEmptySport();
    // }

    super.initState();
  }

// Function to validate the number
  bool isNumber(String? value) {
    if (value == null) {
      return true;
    }
    final n = int.tryParse(value);
    return n != null;
  }

  @override
  Widget build(BuildContext context) {
    final sportProvider = getIt<SportProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Sport"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Sport Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  if (value.length > 10) {
                    return 'Name cannot be greater than 10 characters';
                  }
                },
                onChanged: (String value) => sportProvider.changeName = value,
                controller: nameController,
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sort Order'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  if (isNumber(value)) {
                    final n = int.tryParse(value);
                    sportProvider.changeSortOrder = n!;
                  }
                },
                controller: sortOrderController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sportProvider.saveSport();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
