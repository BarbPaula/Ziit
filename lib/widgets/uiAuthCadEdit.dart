import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mkti_app_aventura/views/common/utils.dart';
import 'package:mkti_app_aventura/views/contants.dart';
import 'package:mkti_app_aventura/views/global/init_page.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:mkti_app_aventura/widgets/CustomTostOverlay.dart';
import 'package:mkti_app_aventura/widgets/unique_choince.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';
import 'uiAuthLogin.dart';
import '../views/global/Dashboard.dart';
import 'package:mkti_app_aventura/data/Sqlite.dart';
import '../data/UserClass.dart';
import '../data/cliente.dart';

import 'package:date_format/date_format.dart';

var nomectrl;
var emailctrl;
var passctrl;
var processing;
var passconfirmctrl;
var referencia;
var mensagem = "";
var acao;

// Tela de Cadastro
// Formulário Cadastro
// Nome
// E-mail
// Senha
// Confirma Senha
// Aceita receber Newsletters?
// Concordo com os Termos de Uso do App

class UiAuthCadEdit extends StatefulWidget {
  @override
  _UiAuthCadState createState() => _UiAuthCadState();
}

class _UiAuthCadState extends State<UiAuthCadEdit> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;

  @override
  void initState() {
    super.initState();

    init();

    nomectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    passconfirmctrl = new TextEditingController();
    referencia = new TextEditingController();
  }

  void showCustomToastOverlay2(msg) {
    CustomToastOverlay().show(context,
        mainText: msg,
        backgroundColor: Color(0xffCBFF00),
        mainTextColor: Colors.black,
        toastLength: Duration(milliseconds: 2500));
  }

  String cp;

  init() async {
    var conn = await getCon();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var results = await conn.query(
        'select * from 00_usuario where 00_cod = ?', [prefs.getInt("id_user")]);

    for (var row in results) {
      nomectrl.text = row['00_nome'];
      emailctrl.text = row['00_email'];
      passctrl.text = row['00_password'];
      referencia.text = row['ref_code'];
      cp = row['00_01_UF'];
    }
    setState(() {});
  }

  void cadastrarUsuario() async {
    if (!_formKey.currentState.validate()) return;
    var email = emailctrl.text;
    var nome = nomectrl.text;
    var password = passctrl.text;
    var ref = referencia.text;

    var conn = await getCon();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res1 = prefs.getString("uf");

    try {
      var res = prefs.getInt("id_user");
      await conn.query(
        'update 00_usuario set 00_nome =?, 00_email=?, 00_password=?, 00_01_UF=?, ref_code=? where 00_cod=? ',
        [nome, email, password, res1, ref, res],
      );

      showCustomToastOverlay2("Editado com sucesso");
    } catch (e) {
      showCustomToastOverlay2("erro ao editar");
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black,
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
                Navigator.pop(
                  context,
                );
              },
            ),
            title: const Text('Editar dados'),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                    child: Center(
                        child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(mensagem, style: TextStyle(color: Colors.red)),

                      // Nome
                      TextFormField(
                          controller: nomectrl,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle,
                                color: Color.fromRGBO(150, 151, 154, 1)),
                            hintText: 'Digite o seu Nome',
                            labelText: 'Nome*',
                          )),
                      SizedBox(
                        height: 10,
                      ),

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

                      cp != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: UniqueChoinceWidget(value: cp))
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),

                      //Senha
                      TextFormField(
                          controller: passctrl,
                          obscureText: true,
                          validator: (value) {
                            print(value.length);
                            if (value.length < 6) {
                              return 'Digite uma senha segura';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,
                                  color: Color.fromRGBO(150, 151, 154, 1)),
                              hintText: 'Digite a sua Senha',
                              labelText: 'Senha*')),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      // Aceite Emails e Avisos

                      Row(
                        children: [
                          Checkbox(
                            value: isSwitched1,
                            activeColor: Color(0xffCBFF00),
                            checkColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                isSwitched1 = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                                'Deseja receber periodicamente informações sobre Energia Renovável'),
                          ),
                        ],
                      ),

                      // Aceite Emails e Avisos
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: isSwitched2,
                            activeColor: Color(0xffCBFF00),
                            checkColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                isSwitched2 = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                'Estou de acordo com os termos e condições padrões do aplicativo'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          cadastrarUsuario();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 60,
                            child: Center(child: Text('CADASTRAR'))),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(65, 64, 66, 1),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                            side: BorderSide(color: Colors.white, width: 1)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ))),
              )),
        ));
  }
}
