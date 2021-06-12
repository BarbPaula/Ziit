import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/global/main_page.dart';

class GASreen extends StatefulWidget {
  @override
  _GASreenState createState() => _GASreenState();
}

class _GASreenState extends State<GASreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff414042),
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Color(0xff414042),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 80.0),
                        Text(
                            "Poxa, que bacana! Você terá 1 ano de carregamento do seu celular com garantia de origem da energia renovável ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: Text("Siga as instruções abaixo, é super simples!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Main();
                          },
                        ));
                      },
                      child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text('GOOGLE PAY'))),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(65, 64, 66, 1),
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          side: BorderSide(color: Colors.white, width: 1)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Main();
                          },
                        ));
                      },
                      child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text('APPLE PAY'))),
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
          )),
    );
  }
}
