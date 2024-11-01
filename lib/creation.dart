import 'package:flutter/material.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

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
      initialDate: null,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString();
        _taskName.text = _taskName.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création'),
      ),
      drawer: TNav(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            TextField(
            controller: _taskName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom de la tâche',
            ),
          ),
              SizedBox(height: 20),

              Text(
                "Date d'échance : ${_selectedDate.split(" ")[0]}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Choississez une date'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: ()async {
                    try{
                      AddTaskRequest req = new AddTaskRequest();
                      req.name = _taskName.text;
                      req.deadline = DateTime.parse(_selectedDate);
                      addTask(req);
                    }catch(e){
                      print(e);
                    }
                Navigator.popAndPushNamed(context, "/acceuil");
              },
                  child:Text("Créer"))
            ],
          ),
        ),
      ),
    );
  }
}
