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
import '../widgets/uiAuthLogin.dart';
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
final date2 = DateTime.now();

// Tela de Cadastro
// Formulário Cadastro
// Nome
// E-mail
// Senha
// Confirma Senha
// Aceita receber Newsletters?
// Concordo com os Termos de Uso do App

class UiAuthCad extends StatefulWidget {
  @override
  _UiAuthCadState createState() => _UiAuthCadState();
}

class _UiAuthCadState extends State<UiAuthCad> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;

  @override
  void initState() {
    super.initState();

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

  void cadastrarUsuario() async {
    if (!_formKey.currentState.validate()) return;
    var email = emailctrl.text;
    var nome = nomectrl.text;
    var password = passctrl.text;
    var ref = referencia.text;
    var notificacoes = (isSwitched1 ? "1" : "2");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = prefs.getString("uf");

    try {
      Dio dio = new Dio();
      print(notificacoes);
      var dt = {
        "00_nome": nome,
        "00_email": email,
        "00_password": password,
        "00_notificacao": notificacoes,
        "00_01_UF": res
      };

      print(jsonEncode(dt));

      Response response = await dio.post(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/cadastra",
          data: jsonEncode(dt));

    } catch (e) {

      if (e.response.data[0]['codigo'] == 1) {
        prefs.setBool("logado", true);
        prefs.setString("name_user", nome);
        prefs.setInt("id_user", e.response.data[0]['00_cod']);
        prefs.setString("porcSolar", "0");
        prefs.setString("porcHidrica", "0");
        prefs.setString("porcEolica","0");
        prefs.setString("porcBiomassa", "0");
        prefs.setString("total", "0");
        prefs.setString("pic", "iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAMAAADDpiTIAAADAFBMVEUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACzMPSIAAAA/3RSTlMAAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2Nzg5Ojs8PT4/QEFCQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaW1xdXl9gYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXp7fH1+f4CBgoOEhYaHiImKi4yNjo+QkZKTlJWWl5iZmpucnZ6foKGio6SlpqeoqaqrrK2ur7CxsrO0tba3uLm6u7y9vr/AwcLDxMXGx8jJysvMzc7P0NHS09TV1tfY2drb3N3e3+Dh4uPk5ebn6Onq6+zt7u/w8fLz9PX29/j5+vv8/f7rCNk1AAAkHklEQVQYGe3BCYBNZf8H8O+5y6yWsbdIyvKS0oZkSasi4hWiQiGFLJVkKUWLvEXWlDbVG222LGUrKUubJdlikGUsiWGYxdx7v//697bo/M7MnZl7z3memfP5oOjwV6jV5NYeQ8a8NWv+kuVfrd2UvOdQakYomJF6aM/2TWu/Wr54/sw3Rw/u0eaqC8r74CosjHL1bhv08rzV244yD45uWzX3pUfa1yljwKWpYhfd0m/snA1pLJDj62e/0LflhYlw6cNbre2Tc3YxonbMGt6mqgcuxZVs3HvK6pOMkhOrXurZsARcSvLXfWDGLtpgxwf9LvfBpZISTUd8epI2OrH48euKwaWCs9uPXxOkAwLfjG17BlxOSrh5UjId9eP4m+LhckTVvp9kUgHp83ufB5e94m4ct40K2Tzm+li4bFKh59x0KufEnB7l4Iq60t2XBKmowMK7k+CKohKd5mdTaVlzbi8GV1QktJ+RSQ2kv39rPFwR5msx7QS1kfZ2My9ckXPuiH3UzO5hFeGKCF+rBSFqKPhRCy9cBVX5yX3U1p4nzoGrAPz//jhErQXntfTBlT9lh6Uw8lKTv162aO6M6VOnTBwzcvjQocNHjpk45c3pM+YuWvZNciojb+/Q0nDlXZVJ6YyUo+vmvPLsw11bNapZ3occ+cvXbNy628BRr360/jgj5cS4ynDlTb0Pgiy4I2tmvtCv1cVJyA+j1CWt+4+dve4oCy4w/XK4wuZp+TkLaN8nz3W5rCQiIqnOXaMX7WcBfdrMgCscsd02sQCOr3z5/iZlEHFlr+k7ZVUaC2BDlxi4cpM4cD/z69TqMW0rG4giz3ntx36dzfza+2A8XDmJ63eQ+XNo9sBG8bBFwlWDPjrM/EnpFQuXFf+9e5kfG1/qXNWArYzqd03ZwvzY1dUHl8TbOZl5d/SDbhXhkHN7zDzGvPuxoweuf/K038y8Cn01ooEPjvI3fvpb5tmGfxtw/Z3Rch3z6MDUDmWhhPJ3vH2IefRtMwOuP9VdybxJGd/IA4V4r550gHnz+aVw/e7MN5gnKeMbeaAc79WTDjAvQlPKwwXEPpLGPEgZ39gDRXmvnnSAeXDswRgUdcYt2xm+IxMbe6A079WTUxm+Lc1QtF2wiOFb0iEOGki4cxnDN786iq5S4wIM176nzoc2qo3cz3BlP18SRZPR7TDDFJh1sw9a8bf6KMgwHepsoAiqspRhSn7kDGjo7CE7GaZPzkVR4xuQzvAsb+2FpnxtVzI8J/p6UaRc/A3DEpheF1q78oMgw7LqAhQdcU9nMxzHnqsE7Z03No3hOPV4DIqIRlsYjl39i6NQSBqwh+H44QoUBSUmMRzr2/lQaPhv38QwhF5IRKHXaBfDsLGtB4WKt+NWhiG5Pgo3/5NB5m5LBy8KHV+n7cxd4DEvCrEqq5m7bXd6USj57t7J3H1xLgoro3Mac7XjLh8KrZh7djNXqR1QOCW9y1ztu8ePQi2210Hm6s0SKIQa/8TcZIwohkKvxMgs5ia5Pgob/5NB5uadSigSzv+AuQk85kWhcvZK5uarK1FkXPUdc/P5GShEmhxkLvbe4UER4rlrP3Ox70oUFkb/AHOW/ngiipjiT2UyZ6d6GigUEqcxF7PPQRFUeQFz8UY8CoEq3zNn+281UCQZHQ8xZ99VhvaaH2XOpiShyCrzBnP2yw3Qm+fxEHO0tQmKtOuTmaPgIAMaS5rLHGU/GYciLmFUgDmaUQLaqryJOVp9EVy49Fvm6PuK0FSdA8xJ1gNeuH7le+QUc7LvEmjplpPMyYaL4PqfyzYzJ2nNoKE+IebkhTi4/pQwiTkJ9IBuvC8wJylN4TrNzQeZk2c90ErCTOZkZlm4/qHCPObkvThopPxXzMGJbgZcJkbPdObgy7LQRo0dzMHX1eAS1VzDHGyrBk1cfpg5mBgDl4W4V5mDQ7WhhYbHaC2jM1w56J5Fa0fqQQPXnaS15EvgylHdn2jt+FVQ3s2ZtDa/FFy5KLuY1tKbQnHtsmkp9LgHrlx5n6G1rNZQWucgLR1tDldYWh+jpUBHKKwnra0/H64wVd9IS6FuUNZDtDa/OFxhK7mY1vpCUY/S2iQflOJPOqvaxQ2ub3Vrm5Y3NqlT48xYqMX/Kq09AiUNoKXQgwZUULJOm17DX56zelc6/ykt+ct3R913XUUowhhMa32hoJ60lNEGDvPWajv4jS8PMXfHvpzQuRpU0CGLlrpBOV1o6dAVcFLVjmO+OME8OfDePRXhuEa/0EqoIxTTLkgrm8+HYy58cMER5s/aoVXgsGrbaCXQCkq5OZtWPisFZ5S/4819LJAVXRPgqLJf0kpWUyjk2kxa+TAWTijXa3mIBXfk2TPhpLiPaCW9MZTR4AStvOWD/Ure9Uk2IyRzXHk4yP8urRyvC0VcdoxWJntguzpvZTCSjg/0wzne12nlSG0oocZhWnnegM38HVcx4n6oC+d4xtPKwSpQQPkdtPKEAXsVH5rCaMgeYsAxxjO0srUMHJfwFa0MgL3iHvqZ0TK3BJwzhFa+iIPDvDNppSds5b9vL6No/ZlwTj9ame6Bs8bQQrALbNVsO6Nr21lwTrcQLTwDR/Whlc6w05nvM+o2loJzutPKPXDQLUFa6AkbeXofow2WeOGc/rQQuAmOqZtOCwNgo/NW0R5PwkFDaSHtYjik8gFaeAI2ujWVNglcAecYI2lhb0U4ImkTLTxvwDaxk2ifdfUS4BhjAi2sLw4HeObSwmQDtjlvDW0V3PL+0Bal4AjP67TwoQH7DaOFtzywTZ0DdEBg5bB6HtjP+x4tDITtbg5R9qEPtml+gk45PLUJbBczl7Lg9bBZ1aOUfRYL29wToJO2PlIBNotfSdnhc2GrxO8p21wKthlIp2W/WxP2KpdM2bdxsJExjbJD58M2famA4NtVYKt/HaHsdQP26U9ZxhWwTfcQlZA9pRzsdFUWZffCNk0CFIXawDZ3BKmKnzvCTrdTdqo+bHL2Qcoegm2uy6ZCZp8JGz1K2b4KsIV/JWUvGrDL+b9QKUdbwj7GG5R95oUdnqRsvg92KbaBigkOhn1illA2BDZoHKRofTHYxZhF9bwTB9skbaIoux6iLuknio5WgW0eoYpWJ8E2NY5TtL04osyYTllz2ObiLCrpqxKwTRvK3kCUdabsCdgmZj0VtbI4bDOKsvaIqippFM33wDYjqawvEmAX31KKUishivyrKUouBdtcEaC6psE25fdQtNyL6BlBUcYlsI3xLVX2IGxTL4uioYiaxkGKOsM+Xam0wHWwzb0UBa5AlJTYRdEk2Kf4Aart8Bmwi/EGRdsTER2TKPo6BvYZRdXNhG3i11M0BlHRiKITVWGfillUXnvYplYGJcF6iIK4LRR1g43GUX0Hy8A2fSjaEIPIe4qimQbsUz6dGngVtjE+pugxRFztbEpSysBGI6mDQE3Y5oyfKcmqiQjzfUPRDbBR0jFqYRbs05KiFR5E1kMUvQA7DaAm6sM+L1F0PyKqSjol38fBTj9SE0tgn8StlKRVQgQZSynJugh2uprauAj2uTybkgUGIqcbRQ/CVtOojVdgo8EU3YGIKX2YktVe2KlMJrWRXgb28a2h5EAJRMo4SrIvgq16UyODYKPLg5SMQoTUClDyFOz1KTWyGXZ6npJT1RARxiJKtsbBVmUC1MklsFHiTko+QkTcQtFVsFdXamUU7NSUohsRAbHbKZkCm82jVnYZsNPblGzyo+AGUrI/CfZKyKRe6sJO5Q5T0hcFdmYaJW1hs6bUzKOwVSdKjpZDQb1ByWwDNhtJzSyHrYyFlExGAdWlJP0c2G01NXOqGGxVJYuC4MUoEGMlJU/AbsWzqZuWsNcoSj4zUBAtKdmbCLs1p3b+A3uVOEjJDSgAzzpK7oTtRlA7y2Czeyj5ykD+taPkKw9sN5faSfPAXt71lLREvnk3U3Il7LeP+rkANruGkvUe5FdnSqbBfuWpoS6w2yxK2iOf/DsoyKgE+91IDT0Hu1U9RcEWH/KnByUj4IBHqKGPYLvnKOmMfInbQ8G+YnDAa9TQVtiu5CEKdviRH/0ouQdO+JwaOuWD7fpQci/yIfEgBTv8cMJe6qg6bBe3l4K9cci7gZTcBSfEh6ij62G/XpT0Q57F7qdgmw9OqEUtdYb9YndTsNuPvOpGyZ1wRAtqaRAc0IOSO5BHns0UbPHCEd2ppQlwQMxOCtYZyJsWlHSAM4ZSSzPghK6U3IC8+ZyCH7xwxjhq6TM4wb+dgkXIk3qUtIVD3qWWvoMjOlNyCfLiAwrWe+CQT6mlbXCEbysF/0UeVAlS0A5O+Z5aOghndKEgUAnhm0TBTh+csoNayoQzYlIoGI2wlU2noD8cc5B6gkMGU5CWhHANo+BYCTgmjXrywRmlT1LwCMLkT6HgOTgnSD3FwyETKfjJi/D8m4JAJTgmjpoqDodUDVHQDOH5mILpcE5paqoUnDKLglkIS+UQBXXhnLLUVCk4pTEFgbMQjicpWA4HlaWmEuEU42sKhiIMvhQKWsNBZaipGDimAwW7vMhdKwqSvXBQGWrKgGN8uym4CbmbT8EjcFIZ6ikABw2jYCZyVSlEs8AZcFJp6ikNDqoUolngTORmBAWz4Kji1FMKnPQxBUOQC98+ClrAUV7qaQucdCsFOz3IWQsK9vngrCxq6Rs4KeYQBTcgZ9MoeAoOO0otLYWjnqfgdeQo4QQF58Nh+6ilmXBUTQpSY5GTdhQsgdO2UUsvwVkrKGiJnMygoCOctpZaehLOupuCd5CDEpk0OxIHpy2llvrAWcXSaHYiAdY6UTARjnufWuoAh71KQTtYm0dBYzjuRWrpGjisKQUfwlLpbJqleOC4J6mlqnCY/zDNMkrASncKxsN5/ailODjtFQruhJUlFDSG8+6gjn6G426gYB4sVAjSLMUD511PHa2F43yHaXaqNGQ9KRgPBdSgjubAeVMouBuyuRQ0ggKKUUdj4LwbKPgAorh0mu3zQAWp1FBvOM93mGbH/JDcSMF4KOEHauhGKGAKBU0gGUdBIyjhE2qoKhRwPQXPQvIjzQ54oIRXqJ9TfijA9wvNvoegGgVToYbB1M8mKOFdCs6BWV8KOkIN7aifGVDC3RTcA7NPaBYqCzVcSv08CSWcRcEsmCRk0uwrKKI49XM71LCeZmkx+KebKRgBVRygdmpDDf+h4Fr80yQKGkAVX1I3WX6o4VoKnsc/JdMs1QdVvE7drIUiYk/S7Af8w9kUfABlDKBu3oAq5lJQBqdrT0E3KKMZddMPquhNQUucbjwFFaGMc6ibRlBFVQpG4XRraLYJCkmlXgIJUEYyzVbgNCWCNHsJCllJvWyAOqbS7FQ8/q4pBZ2hkCnUy+tQRw8KrsLfDaegKhTSh3q5F+q4kIIh+LulNDtkQCENqZeLoA5PKs0W4G/8J2k2GypJDFInqR4o5GOapXrxl7oUDIRSNlEnC6GSxyiojb88QEEjKOW/1MkwqOQ6CnrhLzNodioeSnmAOmkClRQP0mwa/rKLZquhlibUSGYclLKWZlvxp5IUjIFaigepj+VQyySahRLwh8YUtIVivqc+RkAtd1BQF3/oTUFlKOZl6qMJ1PIvCrrjD1NodtyAYrpQGydioBZvBs3G4w+rabYSqqlObXwM1XxHs8/xP96TNHsZyjlMXTwA1Uyl2VEDv6tGwf1QzlzqogZU8xAFlfC7thQ0gXIGUxM7oZymFLTA756koDSU04CamAzlnEXBUPxuDs32QT3+k9RDcyjH+IVm7+F3u2j2CRS0mFo4GQf1LKPZFvy/YhQ8BwU9Si3MhoIm0CwYi99cREEXKKgRtdAFCupBQTX85hYKLoOCYtKpgexSUFADCpriN/0oKAkF+TdSAxv9UFB5Cu7Fb8bS7AgUVPEbauGrs6AeI51mo/CbOTRbA/Wcv5ua2FkZ6tlEs/fxmw00mwnllE2mNn4sDeUsoNk3+JVxgmYvQDXGImpkvgHVvEizw/hVOQr6QTW9qZV7oZqBFBQHUI+CVlBMmVRq5UhpKKY9BbUB3EbBxVDMs9TM01BMPQpaAxhEQRLUUiyVmjmaALVUoOABAC/TLBWKuZva6QS1GBk0Gw9gHs3WQTGfUDvzoJjNNJsJYDXN5kAt8RnUTnos1PIJzT4HsI1mr0AtV1FDDaCWt2i2EcBRmj0LtfSnhu6HWl6g2UHAT8HDUMskamg81PIozQIGKlDQFWqZRw3Nglp6UpCEWhS0glpWUEPLoZZ2FFRFEwoaQS3rqKFvoJZrKaiPWymoCbWsoYa+gVoupqAFelBQHmpZTQ19AbVUpOAuDKHAB7XMp4bmQi3xFAzAGJqlQjGvU0NToJh0mj2Lt2iWDMU8QQ0NhWL20Ow1zKLZ11BMZ2qoAxSzjmbvYT7NlkExV1JDl0ExK2k2C0totgiKSaJ+QolQzGc0W4DlNJsL1eyldrZDNQtpthRf0WwGVDOP2pkB1cyl2RdYS7PpUM1wamcwVPMhzb7GJppNhWqaUTvXQjXTaLYeyTSbAtWUDFIzpxKgmqk024w9NJsI5XxLzayAcl6m2Q4cotkYKOcZauZxKGcCzfYhlWYjoZwG1EwdKGc0zX5GBs2GQzme/dTKHgPKeYZmxxGi2VCoZzy1MhrqeYJmWaBgKNRTh1qpDfU8QbNTCNBsOBS0lhr5Cgp6hmbpyKLZSCjobmrkDihoNM3SkE6zMVBQzF5qY6cPCppAs6M4TrOJUFFPaqMbVPQyzQ7jKM2mQEW+zdTEBi9UNJVmB/Azzd6Ekq6lHkKNoaRpNNuH3TSbDjVNphbGQ00zaLYNW2g2A2qKX0cNfBcLNc2l2XqsodlcKKrSPipvd0UoaiHNVuFLmi2CqmqmUHF7q0NVy2i2FItotgzKqvw9lba2EpS1kmZzMZtm30Bd8eOCVFZgdBzUtY5m7+FtmiVDZRdNz6KSMv97AVS2h2avYjzNUqG2Uu1H7aVido9qmwS1pdPsOYygwAfVvUnFvArVJVAwFA9QUB6qG07FDIXqzqGgF+6moCZUdycV0w6qu4SC29GagsZQ3eVUzEVQ3XUUNEMTClpDdfEBKuVUDFTXnoL6qElBNyhvE5XyPZTXk4LzUYqCgVDe21TKG1DeoxQkwsii2Sgo734qpReUN5ZmaQD20OxVKO9SKuUSKO9tmm0H8C3NPoLyPKlUyDEPlLeQZisAzKfZeqjvIypkLtS3hWYzAUyh2TEDyutDhTwA5RkZNBsP4FEKSkF51amQWlDeGRQMANCZgkugvm1Uxh6orz4F7QFcQ0FrqG8MlfES1NeBgvoAqlDQH+prTGXcDPU9QsFZAGIpGAv1efZTEcdjob7JNMv24lcpNJsNDUykIqZBAx/TbAd+s5xma6GBhlTELdDAZpotxG9ep9lR6GAHlXA0BuozMmg2Cb8ZTEESNPAElfASNFCBgv74TTsK6kADlUNUwZXQQEMKWuA3l1BwF3SwkArYDB3cR8G/8JtiFIyGDtpQAQOgg0k0C8bi/+2m2SLowLeHjssoAx0sp9lW/G4BzfZDC0PouLegA+MozWbgd89RUBY6KJNOp9WBDs6mYAR+dxcF10ALk+mwFdDCTRTcht/VpaAvtFAlQGe1gRYepuBC/C6RginQw3Q66kcPtPAWzbJj8D8/0mwV9FArRCd1hx7W0Gw9/vAuzdI80MP7dNDuGGjBl0mzqfjDQArOgx5qBumc+6CHGhT0xR+up6A9NDGVjtnhhx46UdAIfyhDwVho4pwMOqUTNDGZZqHi+NMumn0NXYykQ9Z6oIn1NNuKv3xIs+wEaKJ4Cp1xHTRRIkSzd/CXARRcBV10oiPmQBc3UHA//tKQgkHQxjI6IOM86OIJCurgL/HZNPsI2qiRSfs9Cm0solm6H3/zNc0OG9DGYNruBz904T1Os+X4u/EUVIc2vKtps0BdaKM2BaPwdx0ouAv6qJZGew2HPu6joDX+7iwKpkAjd9JWK3zQx1s0C5XGaX6k2RboZBJtdLAi9GHspNl6nG4KBedCI/6ltE1WY2ikOgXjcLo7KOgBnZRcR5uEOkInfSlog9NVpGAmtFJuHW0R7A6tLKCgLP5hG82O+aGVkp/QBmltoJW4dJptwD+9SEFj6MXoz6hbVxV6uYGC0finVhQ8Bc0kMeomQDPPU9AU/1QiQLNvoZkkRt14aOYHmmXGw+QLCspDLyUZdWOhl3MoWASzxyi4A3opwah7AXrpRsEAmNWj4G3opTijbgz08gEFF8HMc4Bmh7zQSgKjbjS04j9Ks58MCF6joAm0Es+o+w+0ciMFEyFpRcEkaCWGUfcstPIaBTdCkphJswNe6MTPqHsGOvEfoVlaLETzKWgCnXgYdU9BJzdRMAOyeymYBK0w6kZAJ69R0AWyCiGaHfBCJyFG2xPQiP8IzbJLw8IyCq6GToKMtmHQyE0UfAwrvSmYBJ1kM9qGQiOvU9ANVs4K0eyAFxrJYrQNhj5ijtAsUBaWvqDgamgkg9E2CPpoRsFiWOtHwWRoJIPRNgj6mEpBD1g7I0iz1HjoI4PRNgjaKHGSZqdKIwcLKbgT+khntA2CNu6hYDZy0pmCZdBHBqNtELSxmoJ2yEnxdAqqQRuZjLYh0MWFFByPR46mUzAS2jjFaHsUuniBgjeQs+YU7PdDFyFG2zBoIvYXCq5DznwpFLSCJgxG3XBooj0FOz3IxTMUfARN+Bl1T0MTiygYhtxUoyB4NvSQwKj7D/RQOUSzUCXk6nMKhkAPSYy6sdDDcAoWInddKNjphRYqMOomQwv+vRTchtwlplJwK7RwLqPudWjhDgoOxyEM4yhYCS3UYNRNhw6M7ygYhXDUoORK6OBSRt0c6OBqCkLnIyxLKXgfOmjIqFsCHcylYAHCcysFwfOggZsYdauggX9R0gLh8adQ8AI00I5R9wM08BIFu7wI02MUpJWE+rox6nZDfeUyKBiIcJXLpGAA1Pcgoy4V6nuMghOlELYpFOz2Q3nDGXUhD1QXd5CCCQjfBZTcDuVNYPSVhuq6URCqijz4hIKNXqjuv4y+qlCcP5mC2ciLGynpCNV9zOi7AorrRkkT5IWxloKtPijuW0ZfC6gtZhcFqw3kyW2UdILidjH6ukJt91LSCnnj207Bdh+UZpxk9A2B0mL3ULDRgzzqQcndUFpz2uA7KK0XJZ2RV3H7Kdjph8oW0g4NobC4fRTs8iPPBlByDxRWk7Z4DwrrS0lv5F3iQQp+ioW63qMtArWgrIT9FOyNQz48REkvKKs+bbIAynqQkl7Ij8SDFBwoAVWtoF1ugKJK/0LBnljky4OUjISi7qNttiVCTWMp6Yn8SThAQdZ5UFLVE7TPi1BSjWwK9sQin/pQ8gFU5FtBO90EFc2jpDvyK3YnJY2hoIm01S9VoJ6mlGz1Id/upOQ7D5RzH222sQRU4/uBkrbIP+/3lNwF1TQ9Rbt97IdielLyrYECaEHJ/mJQy7XptN9MH5SSdJiS61EQxnJKnoJSrjpJJ7znhUpGU7IYBVOXkszKUEjLk3TGnHioo3o2BaHaKKC3KVlgQBn3BeiUVWWhCuNTSl5BQZ2TQUlHKML7Hzpoaw0ooislaWegwJ6k5FAZKKH8p3TU8bZQQoUjlAxBwRXbT8kbUEHDvXTaaD8U8C4lu+MRAZ0oug6O848M0nlrasFxN1PUFpFgfEHJ9ng4rNYaKiHzQQ+cVXw3JUsMRMTFQUqehaPinz5FVay+GI4aR0l2TUTIBEoCl8BBNyZTIdnPJcI5V4QoeQ6RUupnSr71wSn/mkvF7O1kwCH+7ylJKYGI6ULRI3BGqbGnqJ6vG8IZwyjqgMgxPqXk1GVwQLFHU6mmORfBAfUDlHxsIIKqZ1KyOQF2i+t/iMoKTqsKuxXfTkn6eYioxyiaBHslPrSfSgu8XQP2eo2ihxFZsZsouhk2Kjn4Zyov+P7FsNGtFK3zI8IahSg5WB52OWf0ceph4fWwy9lHKAnWRcSNo2ieAVtc9vYp6mPNHX7YwbOEomcReYnJFPVE9HnbfkHNpDxWDtH3IEWb4xAFV1OUXgNRVnbQLmoo4/XLEWUXZ1ESuhJRMZGiNXGIpvpvZ1JXq++MRRQlbqRoNKKj2A6KXkHUFLt3DbV26D9VEC3GOxT9mIAoaRikqDuio/bk49ReaNG/fYiKPhQF6iFqnqEosw4ir1j3r1lIpDxdGZHXMJuixxE9MWsp+qksIqzOy8dZiIQW3epHZJ2RQtFqH6KoViZFi72IoJK917LQOTiqGiLIv5yik9UQVf0oexoR0+jNkyycPrs9FpHyAmU9EF3GPMpaISLKPriJhdjhFy5ARHSg7EMDUVZuH0XHqqPAjGvfzWJh92XnOBRYrZMU7SqFqLsmRNHGkiiYsgN+ZJFwZNwFKJjSP1IUuBI2GEHZIj8K4KppWSw6lneMQf7Ffk7ZYNjBt5yyVw3kU4k+G1nEHHq2MvLJeIeyxR7Y4qwDlA1GvtSanMYiKPhRUwP5MYKyveVgk6uDlHVAnnnbfMYia0ufYsizuyjLvhK2GURZZiPkTdKAXSzSUsdURt5cl01ZP9jHM5eyX6ohD6pMPMEiLzCjAfLgglTK3jdgo1LbKdtWFuGq90GQrt+saG0gTGfsomxzCdjqwhOUfRmHsDT7nK4/benmRzgSvqbsWHXY7N+0MMePXHnafkfXaXb3iUOuYj+hLNQcthtOC9O9yJnnzs10mewfkICc+WfRwmDYzzOHFl7zIAdGh810iQ70j0UOPP+lhfcNOKDEBloYZ8DSvzfQZWnPfX5YMV6mhTWJcMS5B2nhaVhovIquHG1rC5kxmhb2nQ2H1M+khSGQ1PyIrlytagjJE7Rw8jI4pgOt9IVJqYkBusLxYSWYPEwLodZw0DBa6YbTee77ma4wpQ+Lw+l60srDcJLxOi2EuuHvrlhDVx7saIm/60krLxpwlP9jWumHPxWfEKQrb96vgD89TCuzvHBYsW9pZQj+p9UeuvLsSFf8zhhOKyvi4bgKybQy0sCvSk2jK18WV8SvjDG0sqUMFFDtEK1M8ABN99KVT0c6AN6XaSXlPCjh0mO08nqxiSG68m9a2f/SypELoYjGGbRylK4COUkrJ66AMppn02WzrOuhkA4humwVbAOldKfLTqFOUExPumzUFcrpR5dt7oOCBtBlk75Q0iC6bPEQFDWALhv0hbL60hV190FhPemKrlBXKK1biK4oCnaG4jpk0xU1WW2gvOYZdEXJieuhgcbH6IqKI1dAC5cepCsKUi6EJqpupyvitlSGNsp/Q1eErSwDjRRbQFdEzYqHVvyv0RVBk7zQjPEoXZESetiAftpn0BURJ1tDS1ccpCsC9l0GTZ27ga4CW3M2tFV8Nl0F9H4iNOZ5nK6CCA0yoLfWaXTlW2pzaK/WNrryaXN1FAJJs+nKl/eLo1AwBgbpyrPsfgYKiyYH6MqjvQ1QiJy5jK48WVwehYr38SBdYQsM9qCwabKXrjDtaoBCqOxcusLyYRIKJaNPBl25OtnDQGF1wXd05WJ1NRRiMU8F6cpBYJgPhVuDZLos/VgPhV6x8XTJQqMTUBRctZ0uweYrUUQkjAnR9Q/BZ+NQdFz5A12nWVcXRUrMkEy6/nRygA9FTdUldP3PgsoogoxOB+n6VcptBoqmpLEBFnnZzxVH0VX7cxZxS2qiSDM67mMRtrutgaIu8fGTLKLShsTDBZw9lUVRcMoZcP3u8mUschbXhutPRrN1LFK+vR6u03g6JrPI2HKrAdc/xfRMYZGwp7sPLkl83/0s9Pb0jIXLSny//SzU9vaKhSsn8f33stD6qXccXLmJ7bqVhdLGzn64wuFt+x0LndWtPHCFy7huHguT0OwmBlx5UmNyOguJExOqwpV3ZQbvYSHw08BScOWPr9VC6i20oIUXrgKo9vwRauvwqPPhKqj425dSR6GFt8XBFRHnjdhNzewcVgmuyPE2fesEtXH8jes8cEVYYsd52dTAqdnt4uGKinK9Pg1SaYHFPUrDFUXleywOUFHZH3crC1fUle066ySVkzajS2m4bBLXfPJeKuSniTfGwmUr45KBS7OogMxFD11kwOWExGZjN9FRG0Y3jYfLSRXaTfyBjlg/rk1ZuFRQrs3zX2bSRunLR7UuA5dKYur1e3cbbbD1nfvr+OFSUsmr+r+1IcAoyV4/tW+j4nApLrZ2x6dmbQsxgoJbZ4y4rVYMXPqIrdnywRcX7wywQLJ3LJzUv8W/YuHSlLdigw4DJ8xamXyCeZC2fcXM8QPa1z/LC1dhUazKlc1v7/3o86+9N3fpqvXb9h04nJqWkX0qPe3o4QP7tq1ftXTue68+N7TX7c3qn5+IIuP/AGip0LbhAGfYAAAAAElFTkSuQmCC");
        prefs.setString("dias", "0");


        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ));
      }
      if (e.response.data[0]['codigo'] == 2) {
        showCustomToastOverlay2("Usuário já existe");
      }
    }
  }

  void selecionaTela(int tipo) {
    if (tipo == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UiAuthLogin();
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    }
  }

  showAlertDialog1(BuildContext context, int tipo) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        selecionaTela(tipo);
      },
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(mensagem),
      content: Text(mensagem),
      actions: [
        okButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tela_01()),
                );
              },
            ),
            title: const Text('Cadastro'),
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

                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: UniqueChoinceWidget()),
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

                      //Confirmar Senha
                      TextFormField(
                          controller: passconfirmctrl,
                          obscureText: true,
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Digite uma senha segura';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,
                                  color: Color.fromRGBO(150, 151, 154, 1)),
                              hintText: 'Confirme a sua senha',
                              labelText: 'Confirme a sua Senha')),
                      SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                          controller: referencia,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                  color: Color.fromRGBO(150, 151, 154, 1)),
                              hintText: 'Codigo de referencia',
                              labelText: 'Codigo de referencia')),
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
