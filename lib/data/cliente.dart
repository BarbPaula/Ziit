import 'package:http/http.dart' as http;
import 'package:mkti_app_aventura/data/assinatura.dart';
import 'package:mkti_app_aventura/data/celular.dart';
import 'dart:convert';


import 'UfClass.dart';

class Cliente{

  

  Cliente({
    this.cod,
    this.nome,
    this.email,
    this.password,
    this.codUf,
    this.cadastro,

  });

  String cod;
  String nome;
  String email;
  String password;
  String codUf;
  estado uf;
  String cadastro;
  String login;
  String mensagem;
  String notificacoes;
  List<Assinatura> assinatura;
  List<Celular> celulares;


  // Salvar Cliente (Cliente)
  
  Future<String> salvaCliente() async{
    

    //Define URL de acesso ao PHP
    // `f04_salvaCliente`(cod int, nome varchar(250), email varchar(200), senha varchar(100), notificacao int, uf int, dtCadastro varchar(10))
  
    String url = "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f04_salvaCliente.php";


    //Faz a requisição
    var res = await http.post(url, body: {"nome":this.nome,
                                          "email": this.email,
                                          "senha" : this.password,
                                          "Uf" : this.codUf,
                                          "notificacao": this.notificacoes
                                          });
    
    //Decodifica Resposta
   
    
    var resposta = jsonDecode(res.body);
    print(resposta);

    if (resposta =="1") {

      this.mensagem = "1";
      
      print("Usuário Cadastrado com sucesso!");

      return "Usuário Cadastrado com sucesso!";

    } else {

      return "Usuário não cadastrado!";

    }

  }

  // From json

  factory Cliente.fromJson(Map<String, dynamic> json){

    return Cliente(
      cod: json['00_cod'],
      nome: json['00_nome'],
      email: json['00_email'],
      password: json['00_password'],
      codUf: json['00_01_uf'],
      cadastro: json['00_dtCadastro'],
    );
  }

  // Atualiza Cliente

  Future<String> atualizaCliente() async{

    //Define URL de acesso ao PHP
    // `f05_editaCliente`(cod int, nome varchar(250), email varchar(200), UF int)
  
    String url = "";
   

    //Faz a requisição
    var res = await http.post(url, body: {"nome":this.nome,
                                          "email": this.email,
                                          "senha" : this.password,
                                          "Uf" : this.codUf,
                                          "notificacao": this.notificacoes
                                          });
    
    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;

  }
  
  
  // Login Cliente
 
   Future<String> loginCliente() async{

    //Define URL de acesso ao PHP
    // `f02_loginUsuario`(email varchar(200), pass varchar (100), perfil int)
  
    String url = "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/login_usuario.php";
   

    //Faz a requisição
    var res = await http.post(url, body: {"email": this.email,
                                          "senha" : this.password,
                                          "perfil": "1"
                                          });
    
    //Decodifica Resposta
    print(res.body);
    
    var resposta = jsonDecode(res.body) as String;

    if (resposta =="1") {

      this.mensagem = "1";
      
      print("Usuário Logado");

      return "Usuário Cadastrado com sucesso!";

    } else if(resposta =="2") {

      this.mensagem = "2";

      print("Login incorreto");

      return "Usuário não cadastrado!";

    } else{

      this.mensagem = "3";

      print("Usuário não cadastrado!");

      return "Usuário não cadastrado!";


    }



  }
  


}