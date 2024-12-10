import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/task.dart';
import 'package:tp1/transfer.dart';
import 'generated/l10n.dart';

class Consultation extends StatefulWidget {
  final String nomTache;

  @override
  _ConsultationState createState() => _ConsultationState();

  Consultation({required this.nomTache});
}

class _ConsultationState extends State<Consultation> with WidgetsBindingObserver {
  bool _isLoading = true;
  final _pourcentage = TextEditingController();
  final _nom = TextEditingController();
  final _date = TextEditingController();
  final _completion = TextEditingController();
  String imageUrl = "";

  var t;

  void getInfos() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentReference<HomeItemPhotoResponse> taskColl = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection('tasks')
          .doc(widget.nomTache.toString())
          .withConverter<HomeItemPhotoResponse>(
        fromFirestore:(snapshot, _) => HomeItemPhotoResponse.fromJson(snapshot.data()!),
        toFirestore: (task,_) => task.toJson(),
      );
      DocumentSnapshot<HomeItemPhotoResponse> docSnapshot = await taskColl.get();
      t = docSnapshot.data();
      // taskColl.add(t);
      // t = await taskDetails(widget.taskID);
      _pourcentage.text = '${t!.pourcentage}';
      _nom.text = t.nom;
      _date.text = t.deadline.toString();
      _completion.text = t.pourcentage.toString() + "%";
      // if (t.photoId != 0) {
      //   imageUrl = SingletonDio.image + t.photoId.toString();
      // }
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
      File f = File(pickedImage.path);

      DocumentReference imageDoc = await FirebaseFirestore.instance.collection("images").add({
        'url':''
      });

      Reference image = FirebaseStorage.instance.ref(imageDoc.id+'.jpg');
      await image.putFile(f);
      var url = await image.getDownloadURL();
      User? user = FirebaseAuth.instance.currentUser;

      DocumentReference task = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection('tasks')
          .doc(widget.nomTache.toString());

      t.photo = url;

      task.update(t);




    }
    setState(() {});
  }

  void delete() async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentReference task = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('tasks')
        .doc(widget.nomTache.toString());

    task.delete();
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
          : OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: imageUrl != ""
                          ? CachedNetworkImage(
                        imageUrl: t.photoId == 0
                            ? imageUrl
                            : SingletonDio.image +
                            t.photoId.toString(),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      )
                          : Text(S.current.no_image),
                    ),
                    SizedBox(width: 10),

                    // Form Fields on the right
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _nom,
                            enabled: false,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: S.current.task_name,
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _date,
                            style: TextStyle(color: Colors.black),
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _completion,
                            enabled: false,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: S.current.time_spent,
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
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
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (t.percentageDone !=
                                        int.parse(_pourcentage.value.text)) {
                                      try {
                                        changeProgress(
                                            t.id, int.parse(_pourcentage.value.text));
                                        Navigator.popAndPushNamed(
                                            context, "/acceuil");
                                      } catch (e) {}
                                    } else {
                                      Navigator.popAndPushNamed(
                                          context, "/acceuil");
                                    }
                                  },
                                  child: Text(S.current.save_button),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: delete,
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: imageUrl != ""
                        ? CachedNetworkImage(
                      imageUrl: t.photoId == 0
                          ? imageUrl
                          : SingletonDio.image +
                          t.photoId.toString(),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    )
                        : Text(S.current.no_image),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nom,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.black),
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
                            if (t.percentageDone !=
                                int.parse(_pourcentage.value.text)) {
                              try {
                                changeProgress(
                                    t.id, int.parse(_pourcentage.value.text));
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
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red)),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.image),
      ),
    );
  }
}
