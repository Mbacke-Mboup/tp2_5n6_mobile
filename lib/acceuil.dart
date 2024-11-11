import 'package:flutter/material.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/task.dart';
import 'package:tp1/transfer.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();
  String imagePlaceholder = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQpZaeWxczipxrTdSIThz5hmwrRYhEeeAl5A&s";
  List<HomeItemPhotoResponse> tasks = [];
  getTask() async {
    try{
      tasks =  await getTasks();
      setState(() {
      });
    }catch(e){
      print(e);
    }

  }
  @override
  void initState() {
    super.initState();
     getTask();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Accueil"),
      ),
      drawer: TNav(),
      body: Center(
        child: Stack(
          children: [
            Container(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Expanded(
                          flex: 1,
                          child: tasks[index].photoId!=0? Image.network(SingletonDio.image+tasks[index].photoId.toString()):Image.network(imagePlaceholder),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(tasks[index].name),
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              child: Text('Pourcentage Fait : ${tasks[index].percentageDone}'),
                            ),
                            PopupMenuItem<String>(
                              child: Text('Temps Écoulé : ${tasks[index].percentageDone}'),
                            ),
                            PopupMenuItem<String>(
                                child: Text('Date Limite : ${tasks[index].deadline.toString().split(" ")[0]}')
                            )
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
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, "/creation");
                    },
                    child: Icon(Icons.add),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
