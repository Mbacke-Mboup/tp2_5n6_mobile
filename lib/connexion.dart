import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

import 'generated/l10n.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

final dio = Dio();

class _ConnexionState extends State<Connexion> {
  bool _isLoading = true;
  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if(user == null){
        setState(() {
          _isLoading = false;
        });
      }else{
        setState(() {
          Navigator.popAndPushNamed(context, "/acceuil");
        });
      }
    });
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
      _getUser();
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken:  googleAuth?.idToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  _getUser() async {


  }

  _setUser(SigninRequest req) {
    _prefs.setString('name', req.username);
    _prefs.setString('password', req.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.current.connexion_title),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      )
          : Center(
            child: SingleChildScrollView(
              child: Center(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: S.current.name_label,
                  ),
                ),
                TextField(
                  controller: _motdePasse,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: S.current.password_label,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _name.text,
                              password: _motdePasse.text
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      child: Text(S.current.login_button),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/inscription");
                      },
                      child: Text(S.current.signup_button),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: ()  {
                      signInWithGoogle();
                      if(FirebaseAuth.instance.currentUser != null){
                        Navigator.popAndPushNamed(context, "/acceuil");
                      }
                    }, child: Text("Connexion avec Google"))
                  ],
                )
              ],
                      ),
                    ),
            ),
          ),
    );
  }
}
