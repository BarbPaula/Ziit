import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/sistema.dart';

Sistema sistema = Sistema();

class ChangeEnergy extends StatefulWidget {
  @override
  _ChangeEnergyState createState() => _ChangeEnergyState();
}

List typs = [
  {"image": "images/change/image_1.png", "name": "SOLAR", "06_cod": 1},
  {"image": "images/change/image_2.png", "name": "HÍDRICA", "06_cod": 2},
  {"image": "images/change/image_3.png", "name": "EÓLICA", "06_cod": 3},
  {"image": "images/change/image_4.jpeg", "name": "BIOMASSA", "06_cod": 4}
];

class _ChangeEnergyState extends State<ChangeEnergy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff231F20),
                height: 60,
                child: Center(
                  child: Container(
                    child: Image(
                        image: AssetImage(
                      'images/cinza.png',
                    )),
                  ),
                ),
              ),
              Container(
                  height: 80,
                  color: Color(0xff414041),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 70.0),
                    child: Text("Escolha a origem da energia para seu celular",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Montserrat")),
                  ))),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  // Cria um grid com duas colunas
                  crossAxisCount: 2,

                  shrinkWrap: true,
                  childAspectRatio: .95,
                  physics: ScrollPhysics(),

                  // Gera 100 Widgets que exibem o seu índice
                  children: typs
                      .map(
                        (e) => GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.setInt("06_cod", e['06_cod']);

                            prefs.setString("energiaImg", e['image']);
                            prefs.setString("energiaDesc", e['name']);

                            sistema.energiaDesc = e['name'];
                            sistema.energiaImg = e['image'];

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Tela_01();
                              },
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0),
                                    child: Image(
                                        image: AssetImage(
                                      e['image'],
                                    )),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(e['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontFamily: "Montserrat"))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
