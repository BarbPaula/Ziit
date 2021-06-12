import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mkti_app_aventura/views/global/Apply.dart';
import 'package:mkti_app_aventura/views/global/home_page.dart';
import 'package:mkti_app_aventura/views/global/curiosidades.dart';
import 'package:mkti_app_aventura/views/global/monitory_energy.dart';
import 'package:mkti_app_aventura/views/global/page_4.dart';
import 'package:mkti_app_aventura/views/global/como_usar.dart';
import 'package:mkti_app_aventura/views/global/perfil.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:mkti_app_aventura/widgets/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

Widget drawer(BuildContext context, _scaffoldKey) {
  return Drawer(
    child: Container(
      color: Color(0xff231F20),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('page 2'),
            onTap: () {
              // Navigator.push(
              //     context, new MaterialPageRoute(builder: (context) => Page2()));
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

class _MainState extends State<Main> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String active = "";
  setActive(name, _page) {
    setState(() {
      active = name;
      page = _page;
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("logado", false);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Splash();
      },
    ));
  }

  int page = 0;

  @override
  Widget build(BuildContext context) {
    List dale = [Page1(), Page2(), Page3(), Page4(), Page5(), Page6(), Aplly()];
    return Container(
        color: Color(0xff414042),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0xff414042),
                  toolbarHeight: 70,
                  title: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => _scaffoldKey.currentState.openDrawer(),
                            child: Container(
                                child: Image.asset(
                                  "images/buttons/button_menu.png",
                                  width: 60,
                                  height: 90,
                                )),
                          ),
                          Container(
                              child: Image.asset(
                                "images/logo_color.png",
                                width: 80,
                                height: 90,
                              )),
                          GestureDetector(
                            onTap: () => {setActive("", 4)},
                            child: Container(
                                child: Image.asset(
                                  "images/buttons/button_info.png",
                                  width: 60,
                                  height: 90,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                key: _scaffoldKey,
                backgroundColor: Color(0xff414042),
                drawer: Drawer(
                  child: Container(
                    color: Color(0xff231F20),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              )),
                          decoration: BoxDecoration(
                            color: Color(0xff231F20),
                          ),
                        ),
                        Column(
                          children: [],
                        ),
                        GestureDetector(
                            onTap: () {
                              setActive("Fonte de Energia", 0);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                active != "Fonte de Energia"
                                                    ? Colors.white
                                                    : Color(0xff231F20),
                                                BlendMode.srcIn),
                                            child: Image.asset(
                                              "images/buttons_drawer/1.png",
                                              height: 30,
                                            ))),
                                    SizedBox(width: 20),
                                    Text("Fonte de Energia",
                                        style: TextStyle(
                                            color: active != "Fonte de Energia"
                                                ? Colors.white
                                                : Color(0xff231F20)))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: active != "Fonte de Energia"
                                      ? Color(0xff414042)
                                      : Color(0xffB8E600),
                                ),
                                height: 50,
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              setActive("Tipo Celular", 1);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                active != "Tipo Celular"
                                                    ? Colors.white
                                                    : Color(0xff231F20),
                                                BlendMode.srcIn),
                                            child: Image.asset(
                                              "images/buttons_drawer/2.png",
                                              height: 35,
                                            ))),
                                    SizedBox(width: 20),
                                    Text("Curiosidades",
                                        style: TextStyle(
                                            color: active != "Tipo Celular"
                                                ? Colors.white
                                                : Color(0xff231F20)))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: active != "Tipo Celular"
                                      ? Color(0xff414042)
                                      : Color(0xffB8E600),
                                ),
                                height: 50,
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              setActive("Freq. de Carga", 2);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                active != "Freq. de Carga"
                                                    ? Colors.white
                                                    : Color(0xff231F20),
                                                BlendMode.srcIn),
                                            child: Image.asset(
                                              "images/buttons_drawer/3.png",
                                              height: 25,
                                            ))),
                                    SizedBox(width: 20),
                                    Text("Freq. de Carga",
                                        style: TextStyle(
                                            color: active != "Freq. de Carga"
                                                ? Colors.white
                                                : Color(0xff231F20)))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: active != "Freq. de Carga"
                                      ? Color(0xff414042)
                                      : Color(0xffB8E600),
                                ),
                                height: 50,
                              ),
                            )),
                        GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              if (prefs.getBool("logado") == null) {
                                setActive("Perfil", 5);
                                Navigator.of(context).pop();
                              }

                              if (prefs.getBool("logado") == true) {
                                setActive("Perfil", 5);
                                Navigator.of(context).pop();
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Tela_01();
                                  },
                                ));
                              }

                              // Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                active != "Perfil"
                                                    ? Colors.white
                                                    : Color(0xff231F20),
                                                BlendMode.srcIn),
                                            child: Image.asset(
                                              "images/buttons_drawer/4.png",
                                              height: 30,
                                            ))),
                                    SizedBox(width: 20),
                                    Text("Perfil",
                                        style: TextStyle(
                                            color: active != "Perfil"
                                                ? Colors.white
                                                : Color(0xff231F20)))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: active != "Perfil"
                                      ? Color(0xff414042)
                                      : Color(0xffB8E600),
                                ),
                                height: 50,
                              ),
                            )),
                        // GestureDetector(
                        //     onTap: () {
                        //       setActive("Data de Adesão", 4);
                        //       Navigator.of(context).pop();
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 20.0, vertical: 5),
                        //       child: Container(
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             SizedBox(width: 20),
                        //             Container(
                        //                 child: ColorFiltered(
                        //                     colorFilter: ColorFilter.mode(
                        //                         active != "Data de Adesão"
                        //                             ? Colors.white
                        //                             : Color(0xff231F20),
                        //                         BlendMode.srcIn),
                        //                     child: Image.asset(
                        //                       "images/buttons_drawer/5.png",
                        //                       height: 32,
                        //                     ))),
                        //             SizedBox(width: 20),
                        //             Text("Data de Adesão",
                        //                 style: TextStyle(
                        //                     color: active != "Data de Adesão"
                        //                         ? Colors.white
                        //                         : Color(0xff231F20)))
                        //           ],
                        //         ),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: active != "Data de Adesão"
                        //               ? Color(0xff414042)
                        //               : Color(0xffB8E600),
                        //         ),
                        //         height: 50,
                        //       ),
                        //     )),
                        GestureDetector(
                            onTap: () {
                              setActive("Quero Assinar", 6);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                active != "Quero Assinar"
                                                    ? Colors.white
                                                    : Color(0xff231F20),
                                                BlendMode.srcIn),
                                            child: Image.asset(
                                              "images/buttons_drawer/6.png",
                                              height: 30,
                                            ))),
                                    SizedBox(width: 20),
                                    Text("Quero Assinar",
                                        style: TextStyle(
                                            color: active != "Quero Assinar"
                                                ? Colors.white
                                                : Color(0xff231F20)))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: active != "Quero Assinar"
                                      ? Color(0xff414042)
                                      : Color(0xffB8E600),
                                ),
                                height: 50,
                              ),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () => logout(),
                            child: Text(
                              "sair",
                              style: TextStyle(
                                color: Color(0xffB8E600),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            child: Image.asset(
                              "images/verde.png",
                              width: 125,
                              height: 63,
                            )),
                      ],
                    ),
                  ),
                ),
                body: dale[page])));
  }
}
