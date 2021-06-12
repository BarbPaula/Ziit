import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import "../widgets/uiAuthLogin.dart";
import "../widgets/uiAuthCad.dart";


var context;


Widget uiHomeAuth(){
  return Center(

    child: Column(

      children:<Widget> [

        // Botão "Fazer Login"; (isso é um widget que chama a tela de Login)
        Row(
          children: <Widget>[

            ElevatedButton(
              onPressed: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) => UiAuthLogin()),
              );} ,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey
              ),
            ),

          ],
        ),

        // Botão "Cadastre-se"; (isso é um widget que chama a tela de cadastro)
        Row(
          children: <Widget>[

            ElevatedButton(
              onPressed: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) => UiAuthCad()),
              );},
              child: Text('Cadastre-se'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey
              ),
            ),

          ],
        ),

        // Barra de Links integração <facebook, instagram e Google > (isso é um widget que chama um widget paa cada integração);


      ],


    ),
  );
}