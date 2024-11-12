import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
      _getUser();
    });
  }

  _getUser() async {
    SigninRequest req = SigninRequest();
    req.username = _prefs.getString('name') ?? '';
    req.password = _prefs.getString('password') ?? '';
    if (req.username == '' && req.password == '') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    await signin(req);
    Navigator.popAndPushNamed(context, "/acceuil");
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
                      setState(() {
                        _isLoading = true;
                      });
                      SigninRequest req = SigninRequest();
                      req.username = _name.text;
                      req.password = _motdePasse.text;
                      await signin(req);
                      _setUser(req);
                      Navigator.popAndPushNamed(context, "/acceuil");
                    } on DioException catch (e) {
                      setState(() {
                        _isLoading = false;
                      });
                      String message = e.response!.data;
                      if (message == "BadCredentialsException") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.invalid_credentials)),
                        );
                      } else if (message == "InternalAuthenticationServiceException") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.account_not_exist)),
                        );
                      } else {
                        print(e);
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
            )
          ],
        ),
      ),
    );
  }
}
