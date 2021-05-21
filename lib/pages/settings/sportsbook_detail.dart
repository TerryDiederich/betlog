import 'package:betlog/models/sportsbook.dart';
import 'package:betlog/providers/setup_getit.dart';
import 'package:betlog/providers/sportbook_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SportsbookDetail extends StatefulWidget {
  final Sportsbook sportsbook;

  SportsbookDetail({required this.sportsbook});

  @override
  _SportsbookDetailState createState() => _SportsbookDetailState();
}

class _SportsbookDetailState extends State<SportsbookDetail> {
  final _formkey = GlobalKey<FormState>();
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
    final sportbookProvider = getIt<SportsbookProvider>();
    nameController.text = widget.sportsbook.name;
    sortOrderController.text = widget.sportsbook.sortOrder.toString();
    sportbookProvider.initializeSportsbook(widget.sportsbook);

    super.initState();
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    if (value.length > 10) {
      return 'Name cannot be greater than 30 characters';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sportsbookProvider = getIt<SportsbookProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Sportsbook'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Sportsbook Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateName(value),
                onChanged: (String value) =>
                    sportsbookProvider.changeName = value,
                controller: nameController,
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sort Order'),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  int? converted = int.tryParse(value);
                  if (converted != null) {
                    sportsbookProvider.changeSortOrder = converted;
                  }
                },
                controller: sortOrderController,
              ),
              ElevatedButton(
                onPressed: () {
                  var form = _formkey.currentState!;
                  if (form.validate()) {
                    sportsbookProvider.saveSportsbook();
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
