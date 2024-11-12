import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/task.dart';
import 'package:tp1/transfer.dart';

import 'generated/l10n.dart';

class Consultation extends StatefulWidget {
  int taskID;

  @override
  _ConsultationState createState() => _ConsultationState();

  Consultation({required this.taskID});
}

class _ConsultationState extends State<Consultation> with WidgetsBindingObserver {
  bool _isLoading = true;
  final _pourcentage = TextEditingController();
  final _nom = TextEditingController();
  final _date = TextEditingController();
  final _completion = TextEditingController();
  String imageUrl = "";

  TaskDetailPhotoResponse t = TaskDetailPhotoResponse();

  void getInfos() async {
    try {
      t = await taskDetails(widget.taskID);
      _pourcentage.text = '${t.percentageDone}';
      _nom.text = t.name;
      _date.text = t.deadline.toString();
      _completion.text = t.percentageTimeSpent.toString().split(" ")[0] + "%";
      if (t.photoId != 0) {
        imageUrl = SingletonDio.image + t.photoId.toString();
      }
      _isLoading = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _isLoading = true;
      });
      getInfos();
    }
  }

  void getImage() async {
    ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageUrl = await sendImage(pickedImage.path, pickedImage.name, t.id);
    }
    setState(() {});
  }

  void delete() async {
    try {
      await removeTask(t.id);
      Navigator.popAndPushNamed(context, "/acceuil");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getInfos();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.consultation_title),
      ),
      drawer: TNav(),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: imageUrl != ""
                  ? CachedNetworkImage(
                imageUrl: t.photoId == 0? imageUrl : SingletonDio.image + t.photoId.toString(),
                placeholder: (context, url) => CircularProgressIndicator(),
              )
                  : Text(S.current.no_image),
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
                labelText: S.current.task_name,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
              ),
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
                labelText: S.current.deadline_label,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
              ),
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
                labelText: S.current.time_spent,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _pourcentage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: S.current.progress_percentage,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (t.percentageDone != int.parse(_pourcentage.value.text)) {
                        try {
                          changeProgress(t.id, int.parse(_pourcentage.value.text));
                          Navigator.popAndPushNamed(context, "/acceuil");
                        } catch (e) {}
                      } else {
                        Navigator.popAndPushNamed(context, "/acceuil");
                      }
                    },
                    child: Text(S.current.save_button),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: delete,
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.image),
      ),
    );
  }
}
