import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/global/google_apple.dart';
import 'package:mkti_app_aventura/widgets/unique_plans.dart';

class Aplly extends StatefulWidget {
  @override
  _ChangeEnergyState createState() => _ChangeEnergyState();
}

class _ChangeEnergyState extends State<Aplly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff414042),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xff414042),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 210,
                    child: Center(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "Ah não! Seu celular está sendo carregado sem a garantia de origem da energia renovável. Vamos resolver isso?",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    fontFamily: "Montserrat")),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Mas antes escolha umas opções abaixo.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Montserrat")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: UniqueChoinceWidget()),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: DottedBorder(
                    color: Color(0xffCCFF00),
                    dashPattern: [7, 7, 7, 7],
                    strokeWidth: 1,
                    child: Container(
                        color: Color(0xff4B4B4B),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                  "1º ano de carregamento com garantia de origem da energia renovável por",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("R\$ 1,99 ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xffCCFF00),
                                      fontSize: 25,
                                    )),
                                Text("/ano",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xffCCFF00),
                                      fontSize: 12,
                                    )),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return GASreen();
                        },
                      ));
                    },
                    child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text('ENVIAR'))),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(65, 64, 66, 1),
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                        side: BorderSide(color: Colors.white, width: 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
