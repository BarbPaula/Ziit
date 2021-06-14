import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mkti_app_aventura/views/common/utils.dart';
import 'package:mkti_app_aventura/views/contants.dart';
import 'package:mkti_app_aventura/views/global/home_page.dart';
import 'package:mkti_app_aventura/views/global/init_page.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:mkti_app_aventura/views/global/main_page.dart';
import 'package:mkti_app_aventura/widgets/CustomTostOverlay.dart';
import 'package:mkti_app_aventura/widgets/unfocus-on-tap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';
import '../widgets/uiAuthCad.dart';
import '../views/global/Dashboard.dart';
import '../data/UserClass.dart';
import '../views/global/recuperar a senha.dart';
import '../data/cliente.dart';

// Tela de Login

var emailctrl;
var passctrl;
var mensagem = "";
Cliente cliente = Cliente();
final date2 = DateTime.now();

// E-mail
// Senha
// Manter Logado

class userLogin {
  userLogin(this.email, this.pass);

  final String email;
  final String pass;

  // Construtor nomeado

  userLogin.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        pass = json['pass'];
}

class UiAuthLogin extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<UiAuthLogin> {
  bool isSwitched1 = false;

  void initState() {
    super.initState();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  setCel() async {
    Dio dio = new Dio();
    var z;
    int r;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt(
      "id_user",
    );

    try {
      var model = prefs.getInt("modelo");
      Response response = await dio.post(
          "https://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/novo",
          data: {"00_cod": id, "01_01_descricao": model, "01_01_cargas": 1000});
      print(response);
      print(id);
    } catch (e) {


      try {
        z = prefs.get("06_cod");
        r = prefs.get("modelo");
        var f = prefs.get("01_02_frequencia");

        print(z);
        print(r);
        print(f);
        Response response = await dio.post(
            "https://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/fonte/novo",
            data: {"06_cod": z, "01_01_cod": r, "01_02_frequencia": f});
        print(response);
      } catch (e) {
        print(e.response);
      }

      try {

        var z = prefs.get("id_user").toString();

        Response response = await dio.get(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuario/totais/$z",
        );
        print(response);


        prefs.setString("porcSolar", response.data[0]['porcSolar'].toString());
        prefs.setString("porcHidrica", response.data[0]['porcHidrica'].toString());
        prefs.setString("porcEolica", response.data[0]['porcEolica'].toString());
        prefs.setString("porcBiomassa", response.data[0]['porcBio'].toString());
        prefs.setString("total", response.data[0]['tot'].toString());
      } catch (e) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var z = prefs.get("id_user").toString();
        print("http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuario/totais/$z");
        prefs.setString("porcSolar", e.response.data[0]['porcSolar'].toString());
        prefs.setString("porcHidrica", e.response.data[0]['porcHidrica'].toString());
        prefs.setString("porcEolica", e.response.data[0]['porcEolica'].toString());
        prefs.setString("porcBiomassa", e.response.data[0]['porcBio'].toString());
        prefs.setString("total", e.response.data[0]['tot'].toString());

      }
    }
  }

  void showCustomToastOverlay2(msg) {
    CustomToastOverlay().show(context,
        mainText: msg,
        backgroundColor: Color(0xffCBFF00),
        mainTextColor: Colors.black,
        toastLength: Duration(milliseconds: 2500));
  }

  final _formKey = GlobalKey<FormState>();

  LoginUsuario() async {
    if (!_formKey.currentState.validate()) return;

    try {
      Dio dio = new Dio();

      Response response = await dio.put(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/Login",
          data: {
            "00_email": emailctrl.text,
            "00_password": passctrl.text,
            "00_perfil": "1"
          });
      if (response.data[0]['retorno'] == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("logado", true);
        prefs.setString("email_user", emailctrl.text);
        prefs.setInt("id_user", response.data[0]['00_cod']);
        prefs.setString("name_user", response.data[0]['00_nome']);
        prefs.setString("pic", response.data[0]['00_pic']);
        var difference = date2.difference(
            DateTime.parse(response.data[0]['00_dtCadastro']));
        prefs.setString("dias", difference.inDays.toString());
        Usuario user = Usuario();
        user.nome = response.data[0]['00_nome'];

        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            }));

        setCel();

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ));
      }



      print(response);
    } catch (e) {

      print("http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/Login");
      print(e.response);
      if (e.response.data[0]['retorno'] == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("logado", true);
        prefs.setString("email_user", emailctrl.text);
        prefs.setInt("id_user", e.response.data[0]['00_cod']);
        prefs.setString("name_user", e.response.data[0]['00_nome']);
        prefs.setString("pic", e.response.data[0]['00_pic']);
        print('foto');
        var difference = date2.difference(DateTime.parse(e.response.data[0]['00_dtCadastro']));
        prefs.setString("dias", difference.inDays.toString());
        Usuario user = Usuario();
        user.nome = e.response.data[0]['00_nome'];

        print('1');



        setCel();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ));
      }

      if (e.response.data[0]['`f02_loginUsuario`(?,?,?)'] == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("logado", true);
        prefs.setString("email_user", emailctrl.text);
        prefs.setString("name_user", e.response.data[0]['00_nome']);
        prefs.setString("dias", e.response.data[0]['00_dtCadastro']);
        setCel();

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Dashboard();

          },
        ));
      }

      if (e.response.data[0]['`f02_loginUsuario`(?,?,?)'] == 3) {
        print("error");
      }
    }
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
      home: SafeArea(
        child: UnfocusOnTap(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(65, 64, 66, 1),
            // resizeToAvoidBottomInset: false,
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
                    MaterialPageRoute(builder: (context) => Tela_01()),
                  );
                },
              ),
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                              child: Image.asset(
                            "images/logo_color.png",
                            width: 140,
                            height: 90,
                          )),
                          SizedBox(
                            height: 60,
                          ),
                          Text(mensagem, style: TextStyle(color: Colors.red)),
                          //Email
                          TextFormField(
                              controller: emailctrl,
                              validator: (value) {
                                if (!Utils.isEmailValid(value)) {
                                  return 'Digite um email válido';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,
                                    color: Color.fromRGBO(150, 151, 154, 1)),
                                hintText: 'Digite o seu Email',
                                labelText: 'Email*',
                              )),
                          SizedBox(
                            height: 15,
                          ),

                          //Senha
                          TextFormField(
                              controller: passctrl,
                              obscureText: true,
                              validator: (value) {
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,
                                    color: Color.fromRGBO(150, 151, 154, 1)),
                                hintText: 'Digite a sua Senha',
                                labelText: 'Senha*',
                              )),

                          // Manter-me Logado

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Tela_04();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Esqueci minha senha',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          Expanded(
                            child: Container(),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              LoginUsuario();
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 50,
                                child: Center(child: Text('ENTRAR'))),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(65, 64, 66, 1),
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                                side: BorderSide(color: Colors.white)),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
