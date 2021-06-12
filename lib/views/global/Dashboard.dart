import 'dart:convert';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mkti_app_aventura/views/global/mes_free.dart';
import 'package:mkti_app_aventura/widgets/CustomTostOverlay.dart';
import 'package:mkti_app_aventura/widgets/unique_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/UserClass.dart';
//import 'package:device_info_plus/device_info_plus.dart';
import '../../data/sistema.dart';
const int maxFailedLoadAttempts = 3;

var modelo;
Sistema sistema = Sistema();

InterstitialAd interstitialAd;

final bannerAdIdAndroid = "ca-app-pub-3940256099942544/6300978111";
final bannerAdIdIos = "ca-app-pub-3940256099942544/2934735716";
final intertstitialAdIdAndroid = "ca-app-pub-3940256099942544/1033173712";
final intertstitialAdIdIos = "ca-app-pub-3940256099942544/4411468910";

String getBannerId() => Platform.isIOS ? bannerAdIdIos : bannerAdIdAndroid;
String getInterstitialId() => Platform.isIOS ? intertstitialAdIdIos : intertstitialAdIdAndroid;

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _value = 1;

  String obtemnome() {
    Usuario user = Usuario();
    dynamic nome = user.nome;

    if (nome == null) {
      nome = "Convidado";
    }

    return "Olá $nome!";
  }

  Future<String> obtemaparelho() async {
    Usuario user = Usuario();
    await user.obtemAparelho();


    if (modelo == null) {
      modelo = "";
    }

    return modelo;
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
      Response response = await dio.post(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/novo",
          data: {"00_cod": id, "01_01_descricao": model, "01_01_cargas": 1000});
      print(response);
      print(id);
    } catch (e) {
      Usuario user = Usuario();
      z = e.response.data[0]['01_01_cod'];
      r = prefs.getInt("06_cod");
      prefs.setInt("modelo", z);

      print(z);
      print(r);

      try {
        Response response = await dio.post(
            "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/aparelho/fonte/novo",
            data: {"06_cod": r, "01_01_cod": z, "01_02_frequencia": value});
        print(response);
      } catch (e) {
        print(e.response);
      }

      try {
        Response response = await dio.post(
            "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/assinaturas/novo",
            data: {"00_cod": id, "01_02_gratuito": 1, "01_02_pagto": 1});
        print(response);
      } catch (e) {
        print(e.response);
      }
      // prefs.setInt("01_01_cod", e.response.data['01_01_cargas']);
      prefs.setInt("01_02_frequencia", r);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    _createInterstitialAd();
    _createRewardedAd();

  }
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }
  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize size =
    await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
    _rewardedAd.dispose();
    _anchoredBanner.dispose();
  }







  String model = "";

  init() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      sistema.so = "2";
      sistema.modeloCel = model;
      setState(() {});
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      sistema.so = "1";
      model = iosInfo.name;
      sistema.modeloCel = model;
      // var model = iosInfo.model;
      setState(() {});
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }
  }

  int value = 0;
  setValues(i) {
    setState(() {
      value = i;
    });
  }


  void showCustomToastOverlay2(msg) {
    CustomToastOverlay().show(context,
        mainText: msg,
        backgroundColor: Color(0xffCBFF00),
        mainTextColor: Colors.black,
        toastLength: Duration(milliseconds: 2500));
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZIIT',
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
      ),
      home: Center(
        child: Container(
          color: Color.fromRGBO(65, 64, 66, 1),
          child: SafeArea(
              bottom: false,
              child: Scaffold(
                  backgroundColor: Color.fromRGBO(65, 64, 66, 1),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Text(" Notamos que você utiliza o $model.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 30.0),
                            Text(
                                "Antes de dar início, precisamos que nos informe quantas vezes você carrega o celular ao dia? Escolha uma da opções abaixo:",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: UniqueChoinceWidget(setValues: setValues)),
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (value == 0) {
                                  showCustomToastOverlay2(
                                      "Selecione a frenquencia");
                                  return;
                                }
                                setCel();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return MesFree();
                                  },
                                ));
                              },
                              child: Container(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Center(child: Text('ENVIAR'))),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(65, 64, 66, 1),
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  side: BorderSide(color: Colors.white, width: 3)),
                            ),

                          ],
                        )),
                  ))),
        ),
      ),
    );
  }
}
