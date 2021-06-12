import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/data/UserClass.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class Page3 extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<Page3> {

  List typs=[];
  var total="0";
  bool loading = false;


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
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/novo",
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
            "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/fonte/novo",
            data: {"06_cod": z, "01_01_cod": r, "01_02_frequencia": f});
        print(response);
      } catch (e) {
        print(e.response);
      }


    }


  }



  init() async {

    setState(() {
      loading = true;
    });



    SharedPreferences prefs = await SharedPreferences.getInstance();

    typs = [
      {"image": "images/change/image_1.png", "name": "SOLAR", "percent": prefs.get("porcSolar")==null?0:prefs.get("porcSolar"), "index":1},
      {"image": "images/change/image_2.png", "name": "HÍDRICA", "percent": prefs.get("porcHidrica")==null?0:prefs.get("porcHidrica"), "index":2},
      {"image": "images/change/image_3.png", "name": "EÓLICA", "percent": prefs.get("porcEolica")==null?0:prefs.get("porcEolica"), "index":3},
      {"image": "images/change/image_4.jpeg", "name": "BIOMASSA", "percent": prefs.get("porcBiomassa")==null?0:prefs.get("porcBiomassa"),  "index":4}
    ];

    total = prefs.get("total")==null?0:prefs.get("total");


    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }




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
                            total+" mW",
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
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                    prefs.setString("energiaImg", e['image']);
                    prefs.setString("energiaDesc", e['name']);
                    prefs.setInt("06_cod", e['index']);
                    setCel();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Main();
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
                            Text(e['percent']+"%",
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
