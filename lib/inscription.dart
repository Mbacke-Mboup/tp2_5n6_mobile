import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

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
  @override
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
    });
    super.initState();
  }


  _setUser(SignupRequest req){
    _prefs.setString('name', req.username);
    _prefs.setString('password', req.password);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Inscription"),
      ),
      body:  _isLoading?  Center(
        child: Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
      )
          :  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextField(
              controller: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nom',
              ),
            ),
            TextField(
              controller: _motdePasse,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mot de passe',
              ),
            ),
            TextField(
              controller:  _confirmMotdePasse,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirmer le mot de passe',
              ),
            ),
            Center(
              child:
                ElevatedButton(
                    onPressed: () async {
                      if(_confirmMotdePasse.text != _motdePasse.text){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Les mots de passes ne correspondent pas.')));
                      }else{
                        try{
                          setState(() {
                            _isLoading = true;
                          });
                          SignupRequest req = new SignupRequest();
                          req.username = _name.text;
                          req.password = _motdePasse.text;
                          await signup(req);
                          _setUser(req);
                          Navigator.pushNamed(context, "/acceuil");
                        }on DioException catch(e){
                          setState(() {
                            _isLoading = false;
                          });
                          String message = e.response!.data;
                          if (message == "UsernameTooShort") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Le nom d'utilisateur est trop court")));
                          } else if(message == "PasswordTooShort") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Le mot de passe est trop court")));
                          } else if(message == "UsernameAlreadyTaken") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Ce nom est déja pris")));
                          } else{
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Une erreur réseau s'est produite. Veuillez réessayez plus tard!")));
                            print(e);
                          }
                        }
                      }


                    },
                    child: Text("Inscription")
                ),

            )
          ],
        ),

      ),

    );
  }
}


