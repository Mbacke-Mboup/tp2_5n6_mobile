import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1/lib_http.dart';
import 'package:tp1/transfer.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});



  @override
  State<Connexion> createState() => _ConnexionState();
}

final dio = Dio();

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print(response);
}

class _ConnexionState extends State<Connexion> {
  bool _isLoading = true;
  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();
  late SharedPreferences _prefs;
  @override
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      _prefs = onValue;
      _getUser();
    });

    super.initState();
  }

   _getUser() async {
    SigninRequest req = new SigninRequest();
    req.username = _prefs.getString('name') ?? '';
    req.password = _prefs.getString('password') ?? '';
    if(req.username==''&& req.password == ''){
      _isLoading = false;
      setState(() {
      });
      return;
    }
    await signin(req);
    Navigator.popAndPushNamed(context, "/acceuil");
  }

   _setUser(SigninRequest req){
    _prefs.setString('name', req.username);
    _prefs.setString('password', req.password);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Connexion"),
      ),
      body: _isLoading?  Center(
        child: Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
      )
          : Center(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      try{
                        _isLoading = true;
                        setState(() {
                        });
                        SigninRequest req = new SigninRequest();
                        req.username = _name.text;
                        req.password = _motdePasse.text;
                        await signin(req);
                        _setUser(req);
                        Navigator.popAndPushNamed(context, "/acceuil");
                      }on DioException catch(e){
                        _isLoading = false;
                        setState(() {

                        });
                        String message = e.response!.data;
                        if (message == "BadCredentialsException") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Nom d'utilisateur ou mo de passe invalide.")));
                        }else if(message == "InternalAuthenticationServiceException"){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Ce compte n'existe pas. Veuillez créer un compte.")));
                        }  else{
                          print(e);
                        }
                      }
                    },
                    child: Text("Connexion")
                ),
                ElevatedButton(
                    onPressed: (){

                      Navigator.pushNamed(context, "/inscription");
                    },
                    child: Text("Inscription")
                ),
              ],
            )
              ],
            ),

        ),

    );
  }
}
