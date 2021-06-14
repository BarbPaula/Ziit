import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/data/UserClass.dart';
import 'package:mkti_app_aventura/views/contants.dart';
import 'package:mkti_app_aventura/views/global/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/sistema.dart';
// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';


Sistema sistema = Sistema();
// COMPLETE: Add NativeAd instance
final BannerAd myBanner = BannerAd(
  adUnitId: Platform.isAndroid? 'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
  size: AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(),
);



class Page1 extends StatefulWidget {
  @override
  _State createState() => _State();
}



class _State extends State<Page1> {

  // COMPLETE: Add NativeAd instance


  // COMPLETE: Add _isAdLoaded
  bool _isAdLoaded = false;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBanner.load();
    init();

  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();

  }

  String name = "";
  String energiaImg;
  String energiaDesc = "";
  bool logado = false;

  int active = 0;

  getActive() async {
    var conn = await getCon();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var results = await conn.query(
        'select * from 00_usuario where 00_cod = ?', [prefs.getInt("id_user")]);

    for (var row in results) {
      setState(() {
        active = row['active_energy'];
        loading = false;
      });
    }
  }

  bool loading = true;

  updateEnergy() async {
    setState(() {
      loading = true;
    });
    var conn = await getCon();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var results = await conn.query(
        'select * from 00_usuario where 00_cod = ?', [prefs.getInt("id_user")]);
    int last;
    for (var row in results) {
      last = row['active_energy'];
    }

    if (last == 0) {
      await conn.query('update 00_usuario set active_energy=? where 00_cod=?',
          [1, prefs.getInt("id_user")]);
    } else {
      await conn.query('update 00_usuario set active_energy=? where 00_cod=?',
          [0, prefs.getInt("id_user")]);
    }

    setCel() async {
      Dio dio = new Dio();
      var z;
      int r;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getInt(
        "id_user",
      );

      Usuario user = Usuario();
      z = user.codAp;
      r = prefs.getInt("06_cod");

      print(z);

      try {
        Response response = await dio.post(
            "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/fonte/novo",
            data: {"06_cod": r, "01_01_cod": z, "01_02_frequencia": 3});
        print(response);
      } catch (e) {
        print(e.response);
      }
    }

    init();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString(
        "name_user",
      );
      energiaImg = prefs.getString("energiaImg");
      energiaDesc = prefs.getString("energiaDesc");
      logado = prefs.getBool("logado");
    });
    if (logado == null) {
      logado = false;
    }

    if (logado == true) {
      getActive();
    }
    setState(() {
      // active = row['active_energy'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Row(
                    children: [
                      Text("Olá, $name!",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                  logado
                      ? "Você está carregando com energia $energiaDesc"
                      : "Você não está carregando com energia $energiaDesc",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: logado ? Colors.white : Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  )),
            ),
            SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 20.0),
                  child: Container(
                    height: 231,
                    child: energiaImg != null
                        ? Image(image: AssetImage(energiaImg))
                        : null,
                  ),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Stack(
            //     overflow: Overflow.visible,
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(20)),
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26,
            //                   blurRadius: 5.0,
            //                   spreadRadius: 1.0,
            //                   offset: Offset(0.7, 0.7))
            //             ]),
            //         child: ClipPath(
            //             clipper: ShapeBorderClipper(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(20)))),
            //             child: Container(
            //               child: Column(
            //                 children: [Text("ola")],
            //               ),
            //               width: 300,
            //               height: 380,
            //               // color: Colors.white,
            //             )),
            //       ),
            //       Positioned(
            //         child: Container(
            //             height: 37,
            //             margin: EdgeInsets.only(
            //               top: 12,
            //               bottom: 12,
            //             ),
            //             child: Container(
            //               color: Colors.black,
            //               height: 37,
            //               width: 37,
            //             )),
            //         right: 85,
            //         left: 85,
            //         bottom: -15,
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            ),
            SizedBox(height: 40.0),
            !loading
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  if (prefs.getBool("logado") == null) {
                    updateEnergy();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Tela_01();
                      },
                    ));
                  }

                  if (prefs.getBool("logado") == true) {
                    updateEnergy();
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Tela_01();
                      },
                    ));
                  }
                },
                child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(!logado
                            ? 'TESTAR COM CARREGAMENTO'
                            : active == 1
                            ? "TESTAR SEM CARREGAMENTO"
                            : 'TESTAR COM CARREGAMENTO'))),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(65, 64, 66, 1),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    side: BorderSide(color: Colors.white, width: 1)),
              ),
            )
                : Center(
              child: CircularProgressIndicator(),
            ),


          ],
        ),
      ),
    );
  }
}
