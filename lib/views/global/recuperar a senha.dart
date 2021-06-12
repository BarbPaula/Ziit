import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:mkti_app_aventura/widgets/uiAuthLogin.dart';
import '../../data/UfClass.dart';

var emailctrl;

class Tela_04 extends StatefulWidget {
  @override
  _Tela_04State createState() => _Tela_04State();
}

class _Tela_04State extends State<Tela_04> {
  @override
  void initState() {
    super.initState();

    emailctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
            primaryColor: Colors.black,

            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platbforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Color.fromRGBO(150, 151, 154, 1),
                  displayColor: Colors.white,
                ),
            inputDecorationTheme: InputDecorationTheme(
                fillColor: Color.fromRGBO(88, 89, 91, 1),
                filled: true,
                labelStyle: TextStyle(color: Colors.grey))),
        home: Scaffold(
            backgroundColor: Color.fromRGBO(65, 64, 66, 1),
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Color.fromRGBO(65, 64, 66, 1),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UiAuthLogin()),
                  );
                },
              ),
              title: const Text('RECUPERAR SENHA'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Image.asset(
                      "images/logo_color.png",
                      width: 190,
                      height: 90,
                    )),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("Esqueceu a senha?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Para redefinir sua senha, digite no campo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text("abaixo o usuário da sua conta de forma correta",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: emailctrl,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,
                              color: Color.fromRGBO(150, 151, 154, 1)),
                          hintText: 'Usuário',
                          labelText: 'Usuário*',
                        )),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Enviaremos uma nova senha para seu e-mail",
                            style: TextStyle(
                                color: Color(0xffCBFF00), fontSize: 14)),
                      ],
                    ),
                    Expanded(child: Container()),
                    ElevatedButton(
                      onPressed: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 60,
                          child: Center(child: Text('ENVIAR'))),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(65, 64, 66, 1),
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          side: BorderSide(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )));
  }
}
