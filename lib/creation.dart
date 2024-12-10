import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  DateTime _selectedDate = DateTime.now();
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
        _selectedDate = picked;
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
      body: Center(
        child: SingleChildScrollView(
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
                  '${S.current.deadline_label}: ${_selectedDate.day} ${_selectedDate.month} ${_selectedDate.year}',
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
                    User? user = FirebaseAuth.instance.currentUser;
                    HomeItemPhotoResponse t = HomeItemPhotoResponse(nom: _taskName.text, pourcentage: 0, deadline: _selectedDate, creation_date: DateTime.now());

                    CollectionReference taskColl = FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .collection('tasks')
                       .withConverter<HomeItemPhotoResponse>(
                      fromFirestore:(snapshot, _) => HomeItemPhotoResponse.fromJson(snapshot.data()!),
                      toFirestore: (task,_) => task.toJson(),
                    );
                    taskColl.add(t);

                  },
                  child: Text(S.current.create_task_button),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
