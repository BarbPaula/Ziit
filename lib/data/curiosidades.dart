import 'package:http/http.dart' as http;
import 'dart:convert';

class Curiosidade{

  Curiosidade({

    this.cod,
    this.data,
    this.conteudo,
    this.titulo,
    this.energia,
    this.link,
    this.visualizado,
    this.acesso
  });

  String data;
  String cod;
  String conteudo;
  String titulo;
  String energia;
  String link;
  String acesso;
  String visualizado;
  String codUser;
  
  

  // From json

  factory Curiosidade.fromJson(Map<String, dynamic> json){

    return Curiosidade(
      cod: json['03_01_cod'],
      data: json['03_01_data'],
      conteudo: json['03_01_conteudo'],
      titulo: json['03_01_titulo'],
      link: json['03_01_link'],
      acesso: json['03_01_acessos'],
      visualizado: json['visualizado']
     
    );
  }

  //Salva Visualização
  //f41_salvaVisualizacaoCuriosidades(cod int, notificacao int)
  Future<String> salvaVisualizacao() async{

    String url = "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f41_salvaVisualizacaoCuriosidades.php";
   

    //Faz a requisição
    var res = await http.post(url, body: {"cod": this.cod,
                                          "notificacao": this.codUser 
                                          });
    
    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;


    return "";
  }



  
}