import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/task.dart';
import 'package:tp1/transfer.dart';
import 'generated/l10n.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with WidgetsBindingObserver {
  bool _isLoading = false;
  String imagePlaceholder = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQpZaeWxczipxrTdSIThz5hmwrRYhEeeAl5A&s";
  late var tasks;

  refresh() {
    setState(() {
      _isLoading = true;
    });
    getTask();
  }

  getTask() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      var result = await FirebaseFirestore.instance.collection("users")
      .doc(user!.uid)
      .collection("tasks").withConverter<HomeItemPhotoResponse>(
        fromFirestore:(snapshot, _) => HomeItemPhotoResponse.fromJson(snapshot.data()!),
        toFirestore: (task,_) => task.toJson(),
      ).get();

      tasks = result.docs;

      _isLoading = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTask();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.current.home),
      ),
      drawer: TNav(),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      )
          : Center(
        child: Stack(
          children: [
            ListView(
                children: tasks.map<Widget>((t) =>  ListTile(
                  title: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: tasks[index].photoId != 0
                      //       ? CachedNetworkImage(
                      //     imageUrl:
                      //     SingletonDio.image + tasks[index].photoId.toString(),
                      //     placeholder: (context, url) => CircularProgressIndicator(),
                      //     errorWidget: (context, url, error) => Icon(Icons.error),
                      //   )
                      //       : CachedNetworkImage(
                      //     imageUrl: imagePlaceholder,
                      //     placeholder: (context, url) => CircularProgressIndicator(),
                      //   ),
                      // ),
                      // SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(t.data().nom),
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            child: Text(S.current.task_percentage + ' ${t.data().pourcentage}'),
                          ),
                          PopupMenuItem<String>(
                            child: Text(S.current.time_spent_task + ' ${t.data().deadline.difference(t.data().creation_date).inDays}'),
                          ),
                          PopupMenuItem<String>(
                            child: Text(S.current.deadline_task + ' ${t.data().creation_date}'),
                          ),
                        ],
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/consultation", arguments: t.id);
                  },
                )).toList(),

            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/creation");
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
