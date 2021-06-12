import 'package:http/http.dart' as http;
import 'dart:convert';

class Celular{

  Celular({

    this.codUsuario,
    this.cod,
    this.codModelo,
    this.cargaModelo,
    this.freqCarga, 
    this.codFonte,
    this.descFonte

  });

  String cod;
  String codUsuario;
  String codModelo;
  String descModelo;
  String cargaModelo;
  String freqCarga;
  String codFonte;
  String descFonte;

  // Salva Celular
  //`f30_salvaModeloCelular`(codUsuario int,descricao varchar(400), freq float, validar int)
    // 01_01_celulares
    // 01_02_fonteAtiva
    // 01_01_01_modelos
    // f30a_salvaModeloCelularCliente.php

  Future<String> salvaCelular() async {

     String url = "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f30a_salvaModeloCelularCliente.php";
   

    //Faz a requisição
    var res = await http.post(url, body: {"cod":this.codUsuario,
                                          "descricao": this.descModelo,
                                          "frequencia": this.freqCarga
                                          });
    
    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;


    return '';


  }

  //`f28_salvaFonteEnergia`(fonte int, celular int)
    // 01_02_fonteAtiva
  
  Future<String> salvaEnergia() async {

     String url = "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f28_salvaFonteEnergia.php";
   

    //Faz a requisição
    var res = await http.post(url, body: {"cod":this.cod,
                                          "fonte": this.codFonte,
                                          "frequencia":this.freqCarga,
                                          "carga": this.cargaModelo
                                          
                                          });
    
    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;

    return "";
  }





  //From json

  factory Celular.fromJson(Map<String, dynamic> json){

    return Celular(

      codUsuario: json['00_cod'],
      cod: json['03_01_cod'],
      codModelo: json['01_01_01_modelo'],
      cargaModelo: json['01_01_consumo'],
      freqCarga: json['01_01_cargas'],
      codFonte: json['06_cod'],
      descFonte: json['06_descricao']

    );
  }



}