import 'package:flutter/material.dart';
import 'package:mkti_app_aventura/views/global/escolha_energia.dart';
import 'package:mkti_app_aventura/views/global/login.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424043),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("TUTORIAL"),
        backgroundColor: Color(0xff424043),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 225,
            child: Image(
                image: AssetImage(
              'images/init_page_image.png',
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "O aplicativo Ziit possibilita ao usuário poder garantir a origem renovável da energia usada para carregar seu celular. E um aplicativo de rastreamento da energia, por meio de Certificados de Energia Renovável, de fontes do tipo solar, hídrica, eólica ou biomassa a sua escolha.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff858789), fontSize: 17),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Saiba Mais",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeEnergy();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Iniciar",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
