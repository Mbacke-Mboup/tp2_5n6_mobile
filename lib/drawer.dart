import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/generated/l10n.dart';

class TNav extends StatelessWidget {
  static String? name = FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser?.email : "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                  child: Text(
                    '${S.current.greeting} $name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(S.current.home),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/acceuil");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text(S.current.create_task),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/creation");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.door_back_door),
                  title: Text(S.current.logout),
                  onTap: () async {
                    SharedPreferences.getInstance().then((onValue) {
                      onValue.remove('name');
                      onValue.remove('password');
                    });
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();


                    try {
                      signout();
                      Navigator.pushReplacementNamed(context, "/");
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            );
          }
      ),
    );
  }
}
