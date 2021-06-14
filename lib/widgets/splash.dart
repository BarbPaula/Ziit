import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mkti_app_aventura/views/global/init_page.dart';
import 'package:mkti_app_aventura/views/global/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RTLMain();
  }
}

class RTLMain extends StatefulWidget {
  @override
  _RTLMainState createState() => new _RTLMainState();
}

class _RTLMainState extends State<RTLMain> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  bool loadding = true;

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logado = prefs.getBool("logado");
    if (logado == null) {
      print(1);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitPage()),
      );
    }
    if (logado == false) {
      print(2);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitPage()),
      );
    }
    if (logado == true) {
      print(3);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Main()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xffCBFF00),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Center(
              child: Container(
                  child: Image.asset(
                "images/logo.png",
                width: 125,
                height: 125,
              )),
            ),
          ),
        ));
  }
}
