import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/task.dart';
import 'package:tp1/transfer.dart';

class Consultation extends StatefulWidget {
  int taskID;
  @override
  _ConsultationState createState() => _ConsultationState();
  Consultation({required this.taskID});

}


class _ConsultationState extends State<Consultation> {
  final _pourcentage = TextEditingController();
  final _nom = TextEditingController();
  final _date = TextEditingController();
  final _completion = TextEditingController();
  String imagePath = "";

  TaskDetailResponse t = new TaskDetailResponse();
  void getInfos() async {
    try {
      t = await taskDetails(widget.taskID);
      _pourcentage.text = '${t.percentageDone}';
      _nom.text = t.name;
      _date.text = t.deadline.toString();
      _completion.text = t.percentageTimeSpent.toString().split(" ")[0] + "%";
      setState((){
      });
    }catch(e){
      print(e);
    }
  }

  void getImage() async {
    ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;
    setState(() {});
  }




  @override
  void initState() {
    getInfos();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
      ),
      drawer: TNav(),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 150,
                  child:  imagePath!=""?Image.file(File(imagePath)):Text("Pas d'image"),
                ),
                SizedBox(height: 20),
                
                TextFormField(
                    controller: _nom,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nom de la tache",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    )
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _date,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Date limite",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    )
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _completion,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Temp écoulé",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),

                    )
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _pourcentage,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Pourcentage d'avancement",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                  )
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if(t.percentageDone != int.parse(_pourcentage.value.text)){
                        try{
                          changeProgress(t.id, int.parse(_pourcentage.value.text));
                          Navigator.popAndPushNamed(context, "/acceuil");

                        }catch(e){

                        }
                      }else{
                        Navigator.popAndPushNamed(context, "/acceuil");
                      }
                    },
                    child:Text("Sauveguarder")
                )

              ],
            ),
          ),

      ),
      floatingActionButton: imagePath==""?
      FloatingActionButton(
          onPressed: getImage,
        child: const Icon(Icons.image),
      ):
      Text(""),
    );
  }
}
