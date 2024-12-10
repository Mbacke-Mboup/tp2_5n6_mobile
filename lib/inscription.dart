import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

import 'generated/l10n.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();
  final _confirmMotdePasse = TextEditingController();
  bool _isLoading = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
    });
  }

  _setUser(SignupRequest req) {
    _prefs.setString('name', req.username);
    _prefs.setString('password', req.password);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.current.signup_title),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      )
          : Center(
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
            TextField(
              controller: _confirmMotdePasse,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.current.confirm_password_label,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _name.text,
                      password: _motdePasse.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(S.current.signup_button),
              ),
            ),
            ElevatedButton(onPressed: ()  {
              signInWithGoogle();
              if(FirebaseAuth.instance.currentUser != null){
                Navigator.popAndPushNamed(context, "/acceuil");
              }
            }, child: Text("Connexion avec Google"))
          ],
        ),
      ),
    );
  }
}
