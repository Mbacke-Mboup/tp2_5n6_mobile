import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1/acceuil.dart';
import 'package:tp1/connexion.dart';
import 'package:tp1/consultation.dart';
import 'package:tp1/creation.dart';
import 'package:tp1/inscription.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => Connexion(),
        "/inscription": (context) => Inscription(),
        "/acceuil": (context) => Accueil(),
        "/creation": (context) => Creation(),
        "/consultation": (context) {
          final arg = ModalRoute.of(context)!.settings.arguments as int;
          return Consultation(taskID : arg);
        }
      },
    );
  }
}

