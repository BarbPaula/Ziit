import 'package:http/http.dart' as http;
import 'dart:convert';

class Notificacao{

  Notificacao({

    this.cod,
    this.data,
    this.conteudo,
    this.titulo,
  
    this.link,
    this.visualizado
  });

  String data;
  String cod;
  String conteudo;
  String titulo;
  String codUser;
  String link;

  String visualizado;
  
  

  // From json

  fromJson(Map<String, dynamic> json){

    return Notificacao(
      cod: json['03_01_cod'],
      data: json['03_01_data'],
      conteudo: json['03_01_conteudo'],
      titulo: json['03_01_titulo'],
      link: json['03_01_link'],
      visualizado: json['visualizado']
     
    );
  }

//Salva Visualização
//f40_salvaVisualizacaoNotificacao(cod int, notificacao int)

  Future<String> salvaVisualizacao() async{

    String url = "";
   

    //Faz a requisição
    var res = await http.post(url, body: {"cod":this.cod,
                                          "notificacao": this.codUser 
                                          
                                          });
    
    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;


    return "";
  }



  
}