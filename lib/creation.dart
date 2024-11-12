import 'package:flutter/material.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

import 'generated/l10n.dart';

class Creation extends StatefulWidget {
  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  String _selectedDate = "";
  final TextEditingController _taskName = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.creation_title),
      ),
      drawer: TNav(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _taskName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: S.current.task_name_label,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${S.current.deadline_label}: ${_selectedDate.split(" ")[0]}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(S.current.select_date_button),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    AddTaskRequest req = AddTaskRequest();
                    req.name = _taskName.text;
                    req.deadline = DateTime.parse(_selectedDate);
                    await addTask(req);
                  } catch (e) {
                    print(e);
                  }
                  Navigator.popAndPushNamed(context, "/acceuil");
                },
                child: Text(S.current.create_task_button),
              )
            ],
          ),
        ),
      ),
    );
  }
}
