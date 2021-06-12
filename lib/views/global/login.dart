import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mkti_app_aventura/views/global/main_page.dart';
import '../../widgets/uiAuthCad.dart';
import '../../widgets/uiAuthLogin.dart';
import 'Dashboard.dart';
import 'home_page.dart';
import '../../data/UserClass.dart';
import 'package:dio/dio.dart';
import 'dart:async';

// Página de Login

class Tela_01 extends StatelessWidget {

  semCad() async{
    Dio dio = new Dio();

    Response response = await dio.post(
        "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/anonimo",
        data: {

        });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(204, 255, 0, 1),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  child: Image(
                      image: AssetImage(
                        'images/logo.png',
                      )),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    Usuario user = Usuario();

                    if (user.logado == "true") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ),
                      );

                      return "";
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UiAuthCad()),
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 55,
                      child: Center(child: Text('CADASTRE-SE'))),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        Usuario user = Usuario();

                        if (user.logado == "true") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Dashboard();
                              },
                            ),
                          );

                          return "";
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UiAuthLogin()),
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 55,
                          child: Center(child: Text('FAZER LOGIN'))),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        onSurface: Colors.black,
                      )),
                ),
                SizedBox(height: 20),
                FlatButton(
                    onPressed: ()  {
                      semCad();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Main();
                          },
                        ),
                      );
                    },
                    child: Text('Entrar sem cadastro')),
                SizedBox(height: 10),
                Divider(
                  indent: 30,
                  endIndent: 30,
                ),
                Text("Fazer login com"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.black,
                            child: Icon(
                              FontAwesome.facebook,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.black,
                            child: Icon(
                              AntDesign.googleplus,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.black,
                            child: Icon(
                              FontAwesome.twitter_square,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 40,
                ),
                SizedBox(height: 40),
                Container(
                  height: 100,
                  child: Image(
                      image: AssetImage(
                        'images/logo_renovavel.png',
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
