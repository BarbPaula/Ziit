import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/sistema.dart';
import 'main_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

Sistema sistema = Sistema();

class Page2 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Page2> {
  List typs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    myBanner.load();
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();

  }
  bool _isAdLoaded = false;

  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid? 'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  bool loading = false;

  init() async {
    setState(() {
      loading = true;
    });
    Dio dio = new Dio();
    try {
      var res = await dio.get(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/curiosidades/mobile/01");
      print(2);
      typs = res.data;
    } catch (e) {
      setState(() {
        print(3);
        print(e.response.data);
        typs = e.response.data;
      });
    }
    // print(res);
    setState(() {
      loading = false;
    });
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Text(
                  "Curiosidades",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GridView.count(
              // Cria um grid com duas colunas
              crossAxisCount: 1,

              shrinkWrap: true,
              childAspectRatio: 3,
              physics: ScrollPhysics(),

              // Gera 100 Widgets que exibem o seu índice
              children: typs
                  .map(
                    (e) => GestureDetector(
                      onTap: () => _launchURL(e['03_01_link']),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 0),
                          child: Container(
                              height: 10,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Color(0xff231F20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Curiosidades",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Montserrat"),
                                        ),
                                        SizedBox(height: 12),
                                        Text(e['03_01_titulo'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Montserrat")),
                                        SizedBox(height: 12),
                                        GestureDetector(
                                          onTap: () =>
                                              _launchURL(e['03_01_link']),
                                          child: Text(
                                            "Link original",
                                            style: TextStyle(
                                                color: Color(0xffCCFF00),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Montserrat"),
                                          ),
                                        )
                                      ],
                                    ),
                                  )))),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(
              vertical: 20.0),
            child:Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            ),
          )
        ],
      ),
    );
  }
}
