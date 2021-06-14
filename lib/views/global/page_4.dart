import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/global/login.dart';

import 'main_page.dart';

class Page4 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Page4> {
  List typs = [
    {"image": "images/change/image_1.png", "name": "SOLAR", "percent": "90%"},
    {"image": "images/change/image_2.png", "name": "HÍDRICA", "percent": "5%"},
    {"image": "images/change/image_3.png", "name": "EÓLICA", "percent": "5%"},
    {"image": "images/change/image_4.jpeg", "name": "BIOMASSA", "percent": "0%"}
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
                height: 100,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xff231F20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quantidade de energia \nrenovável rastreada",
                              style: TextStyle(
                                  color: Color(0xffCCFF00),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Montserrat")),
                          Text(
                            "40 Wh",
                            style: TextStyle(
                                color: Color(0xffCCFF00),
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Montserrat"),
                          )
                        ],
                      ),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GridView.count(
              // Cria um grid com duas colunas
              crossAxisCount: 1,

              shrinkWrap: true,
              childAspectRatio: 3.5,
              physics: ScrollPhysics(),

              // Gera 100 Widgets que exibem o seu índice
              children: typs
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 50,
                                      child: Image(
                                          image: AssetImage(
                                        e['image'],
                                      )),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(e['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Montserrat"))
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Text(e['percent'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Montserrat"))
                              ],
                            ),
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
    );
  }
}
