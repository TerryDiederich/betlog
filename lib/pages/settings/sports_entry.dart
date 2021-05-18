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

    super.initState();
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    if (value.length > 10) {
      return 'Name cannot be greater than 10 characters';
    }
    return null;
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
                validator: (value) => _validateName(value),
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
                  int? converted = int.tryParse(value);
                  if (converted != null) {
                    sportProvider.changeSortOrder = converted;
                  }
                },
                controller: sortOrderController,
              ),
              ElevatedButton(
                onPressed: () {
                  var form = _formKey.currentState!;
                  if (form.validate()) {
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
