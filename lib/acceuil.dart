import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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
  bool _isLoading = true;
  String imagePlaceholder = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQpZaeWxczipxrTdSIThz5hmwrRYhEeeAl5A&s";
  List<HomeItemPhotoResponse> tasks = [];

  refresh() {
    setState(() {
      _isLoading = true;
    });
    getTask();
  }

  getTask() async {
    try {
      tasks = await getTasks();
      _isLoading = false;
      setState(() {});
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.network_error),
          duration: Duration(days: 1),
          backgroundColor: Colors.deepPurpleAccent,
          action: SnackBarAction(
            label: 'Rafraîchir',
            onPressed: refresh,
          ),
        ),
      );
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getTask();
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
            ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: tasks[index].photoId != 0
                            ? CachedNetworkImage(
                          imageUrl:
                          SingletonDio.image + tasks[index].photoId.toString(),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                            : CachedNetworkImage(
                          imageUrl: imagePlaceholder,
                          placeholder: (context, url) => CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(tasks[index].name),
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            child: Text(S.current.task_percentage + ' ${tasks[index].percentageDone}'),
                          ),
                          PopupMenuItem<String>(
                            child: Text(S.current.time_spent_task + ' ${tasks[index].percentageDone}'),
                          ),
                          PopupMenuItem<String>(
                            child: Text(S.current.deadline_task + ' ${tasks[index].deadline.toString().split(" ")[0]}'),
                          ),
                        ],
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/consultation", arguments: tasks[index].id);
                  },
                );
              },
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
