
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/widgets/splash.dart';
import 'widgets/uiAuthLogin.dart';
import 'widgets/uiAuthCad.dart';
import 'package:mkti_app_aventura/data/Sqlite.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future inic() async {
  WidgetsFlutterBinding.ensureInitialized();
  criaTabela();
}

List <String> getAppId() => [Platform.isIOS
    ? 'ca-app-pub-3940256099942544~1458002511'
    : 'ca-app-pub-3940256099942544~3347511713'];

void main() {
  runApp(MyApp());
}



final bannerAdIdAndroid = "ca-app-pub-3940256099942544/6300978111";
final bannerAdIdIos = "ca-app-pub-3940256099942544/2934735716";
final intertstitialAdIdAndroid = "ca-app-pub-3940256099942544/1033173712";
final intertstitialAdIdIos = "ca-app-pub-3940256099942544/4411468910";

String getBannerId() => Platform.isIOS ? bannerAdIdIos : bannerAdIdAndroid;
String getInterstitialId() => Platform.isIOS ? intertstitialAdIdIos : intertstitialAdIdAndroid;

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
