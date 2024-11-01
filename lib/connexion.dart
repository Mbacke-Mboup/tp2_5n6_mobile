import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController _name = TextEditingController();
  final _motdePasse = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Connexion"),
      ),
      body: Center(
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
                        SigninRequest req = new SigninRequest();
                        req.username = _name.text;
                        req.password = _motdePasse.text;
                        await signin(req);
                        Navigator.popAndPushNamed(context, "/acceuil");
                      }on DioException catch(e){
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
