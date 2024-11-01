import 'package:flutter/material.dart';
import 'package:tp1/lib_http.dart';

class TNav extends StatelessWidget {
  static String name = "";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Bonjour ' + name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/accueuil");

            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Création'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/creation");
            },
          ),
          ListTile(
            leading: Icon(Icons.door_back_door),
            title: Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              try{
                signout();
                name = "";
                Navigator.popAndPushNamed(context, "/");
              }catch(e){

              }

            },
          ),
        ],
      ),
    );
  }
}
