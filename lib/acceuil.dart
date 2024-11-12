import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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

class _AccueilState extends State<Accueil> with WidgetsBindingObserver {
  bool _isLoading = true;

  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();
  String imagePlaceholder = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQpZaeWxczipxrTdSIThz5hmwrRYhEeeAl5A&s";
  List<HomeItemPhotoResponse> tasks = [];
  refresh(){
    setState(() {
      _isLoading = true;
    });
    getTask();
  }
  getTask() async {
    try{
      tasks =  await getTasks();
      _isLoading = false;
      setState(() {
      });
    }on DioException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Une erreur réseau s'est produite. Veuillez réessayez!"),
          duration: Duration(days: 1),
          backgroundColor: Colors.deepPurpleAccent,
          action: SnackBarAction(
            label: 'Rafrachir',
            onPressed: refresh
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
        title: Text("Accueil"),
      ),
      drawer: TNav(),
      body: _isLoading?  Center(
        child: Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
      )
          :  Center(
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
                                child: tasks[index].photoId!=0? CachedNetworkImage(
                                  imageUrl: SingletonDio.image+tasks[index].photoId.toString(),
                                  placeholder: (context, url) => new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                ):CachedNetworkImage(
                                  imageUrl: imagePlaceholder,
                                  placeholder: (context, url) => new CircularProgressIndicator(),
                                ),
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
