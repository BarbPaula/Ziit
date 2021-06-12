import 'package:mkti_app_aventura/data/cliente.dart';
import 'package:mkti_app_aventura/data/curiosidades.dart';
import 'package:mkti_app_aventura/data/notificacoes.dart';
import 'package:mkti_app_aventura/data/celular.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/cliente.dart';

class Sistema {
  static Sistema _instance;

  Sistema._internalConstructor();

  factory Sistema() {
    _instance ??= Sistema._internalConstructor();
    return _instance;
  }

  Cliente cliente;
  Celular celular;
  String energia; // Tela primeiro acesso
  String energiaDesc;
  String energiaImg;
  String frequencia;
  String so;
  String modeloCel;
  List<Curiosidade> curiosidades;
  List<Notificacao> notificacoes;
  List<Cliente> clientes;
  List<Celular> celulares;
  bool login = false; // sinaliza se usuário está logado

  // Login
  // Cadastro

  // Preenche Cliente
  Future<String> preencheCliente() async {
    String url =
        "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f06a_buscaCliente.php";

    //Faz a requisição
    var res = await http.post(url, body: {
      "email": this.cliente.email,
    });

    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body);

    if (resposta != "0") {
      this.clientes =
          List<Cliente>.from(resposta.map((model) => Cliente.fromJson(model)));
      this.cliente.cod = clientes[0].cod;
      this.cliente.nome = clientes[0].nome;
    }

    return "";
  }

  // Preenche Celular
  Future<String> preencheCelular() async {
    String url =
        "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f27_buscaCelular.php";

    //Faz a requisição
    var res = await http.post(url, body: {
      "cod": this.cliente.cod,
    });

    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body);

    if (resposta != "0") {
      this.celulares =
          List<Celular>.from(resposta.map((model) => Celular.fromJson(model)));
    }

    return "";
  }

  // Rotina busca curiosidades
  // Preenche Celular
  Future<String> buscaCuriosidades() async {
    String url =
        "http://barbara.marciomkt.com.br/mkti_ziit/template3/FreshUI%202.1%20by%20pixelcave/connect_retaguarda/f34_buscaCuriosidadeMobile.php";

    //Faz a requisição
    var res = await http.post(url, body: {
      "cod": this.cliente.cod,
    });

    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body);

    if (resposta != "0") {
      this.curiosidades = List<Curiosidade>.from(
          resposta.map((model) => Curiosidade.fromJson(model)));
    }

    return "";
  }

  Future<String> inicio() async {
    await preencheCliente();
    //await preencheCelular();
    //await buscaCuriosidades();

    return "";
  }

  // Totais de Energia
  // Eólica
  // Biomassa
  // Hidríca
  // Solar
  // Preenche Celular

  Future<String> totaisEnergia() async {
    String url = "";

    //Faz a requisição
    var res = await http.post(url, body: {
      "cod": this.cliente.cod,
    });

    //Decodifica Resposta
    print(res.body);
    var resposta = jsonDecode(res.body) as String;

    return "";
  }

  // Lembrete de Vencimento

}
