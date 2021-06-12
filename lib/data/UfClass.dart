//Classe UF - Padrão Singleton 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Sqlite.dart';
import 'dart:ffi';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';


class Uf{

  static Uf _instance;
  
  List<estado> list;
  

   Uf._internalConstructor(); 

  factory Uf(){


    _instance ??= Uf._internalConstructor();

    return _instance;

  }


  setList() async{
    
    await _buscaDados();
    this.list = await listaEstado();
    print(this.list);
    
    
  }




  // Converte o retorno em Lista
  List<estado> parseEstado(String responseBody) {
    
    final resposta = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    
    return resposta.map<estado>((json) => estado.fromJson(json)).toList();
  }


  // Busca Estados;
  void _buscaDados() async{

    

    // Define URL de acesso ao PHP
    String url = "http://barbara.marciomkt.com.br/mkti_ziit/connect/UF.php";
    //Envia Dados para o servidor
    var res = await http.post(url, body: {"email":"_email",});



    //Decodifica Resposta
    // Use the compute function to run parsePhotos in a separate isolate.
    var lista = (jsonDecode(res.body) as List).map((e) => {

      insereEstado(estado.fromJson(e))
      
    
    }).toList();
  
  }

}


// Classe Espelho Consulta

class estado{
  
  const estado({

    this.cod,
    this.sigla,
  });

  final String cod;
  final String sigla;

  factory estado.fromJson(Map<String, dynamic> json) {

    return estado(
        cod: json['cod'],
        sigla: json['sigla'],
       
    );
  }

   Map<String, dynamic> toJson() => {
       
        "cod": cod,
        "sigla": sigla,
       
      };



}
 