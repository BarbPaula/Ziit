import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/widgets/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/uiAuthLogin.dart';
import 'widgets/uiAuthCad.dart';
import 'package:mkti_app_aventura/data/Sqlite.dart';
import 'package:flutter/widgets.dart';


Future inic() async {
  WidgetsFlutterBinding.ensureInitialized();

  criaTabela();
}

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aventura',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      initialRoute: '/',
      routes: {
        '/Cadastro_usuario': (context) => UiAuthCad(),
        '/Login_usuario': (context) => UiAuthLogin(),
        '/Dashboard': (context) => UiAuthLogin(),
      },
    );
  }
}
