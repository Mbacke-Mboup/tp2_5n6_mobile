import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
                  if (_confirmMotdePasse.text != _motdePasse.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.current.passwords_do_not_match)),
                    );
                  } else {
                    try {
                      setState(() {
                        _isLoading = true;
                      });
                      SignupRequest req = SignupRequest();
                      req.username = _name.text;
                      req.password = _motdePasse.text;
                      await signup(req);
                      _setUser(req);
                      Navigator.pushNamed(context, "/acceuil");
                    } on DioException catch (e) {
                      setState(() {
                        _isLoading = false;
                      });
                      String message = e.response!.data;
                      if (message == "UsernameTooShort") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.username_too_short)),
                        );
                      } else if (message == "PasswordTooShort") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.password_too_short)),
                        );
                      } else if (message == "UsernameAlreadyTaken") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.username_already_taken)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.current.network_error)),
                        );
                      }
                    }
                  }
                },
                child: Text(S.current.signup_button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
