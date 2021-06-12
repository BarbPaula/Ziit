//Classe Usuário - Padrão Singleton
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Sqlite.dart';
import 'dart:ffi';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
// import 'package:device_info/device_info.dart';

class Usuario {
  static Usuario _instance;

  Usuario._internalConstructor();

  factory Usuario() {
    _instance ??= Usuario._internalConstructor();
    return _instance;
  }

  String _cod;
  String _email;
  String _senha;
  String nome = "Convidado";
  String _cpf;
  String _retornoGrava;
  String _retornaNome;
  String logado;
  String aparelho;
  String codAp;

  // Set/Get cod
  set cod(String cod) {
    _cod = cod;
  }

  String get cod {
    return _cod;
  }

  // Set/Get email
  set email(String email) {
    _email = email;
  }

  String get email {
    return _email;
  }

  // Set/Get senha
  set senha(String senha) {
    _senha = senha;
  }

  String get senha {
    return _senha;
  }





  // Set/Get cpf
  set cpf(String cpf) {
    _cpf = cpf;
  }

  String get cpf {
    return _cpf;
  }

  String get retornoGrava {
    return _retornoGrava;
  }

  String get retornoNome {
    return _retornaNome;
  }

  //Função Cadastra Usuário
  Future<String> cadastrarUsuario() async {
    // Define URL de acesso ao PHP
    String url =
        "http://barbara.marciomkt.com.br/mkti_ziit/connect/cadastro_usuario.php";

    //Envia Dados para o servidor
    var res = await http.post(url, body: {
      "name": nome,
      "email": _email,
      "pass": _senha,
    });

    //Decodifica Resposta
    var resposta = jsonDecode(res.body);

    //Retorna Resposta
    this._retornoGrava = resposta['resposta'];

    //Cadastra no Bd interno
    this.cadastraBancoInterno();

    return "";
  }

  //Cadastra no BD interno
  Future<String> cadastraBancoInterno() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Referencia para o banco
    final db = await SqliteDB().db;

    await db.insert(
      'f00_usuario',
      this._toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await _buscadado();
    await obtemAparelho();

    return "";
  }

  // Transforma os dados em Map
  Map<String, dynamic> _toMap() {
    return {
      'f00_id': '00',
      'f00_email': _email,
      'f00_nome': nome,
      'f00_senha': _senha,
    };
  }

  // Busca Dados SQlite

  Future<List<Usuario>> _buscadado() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Referencia para o banco
    final db = await SqliteDB().db;

    // Busca Singular
    List<Map<String, dynamic>> resultado = await db.rawQuery(
        'SELECT * FROM  f00_usuario WHERE f00_email=?', [this._email]);

    List.generate(resultado.length, (i) {
      this._retornaNome = resultado[i]['f00_nome'];
      this.logado = "true";

      if (this._retornaNome == null) {
        this._retornaNome = "Convidado";
      }
    });
  }

  void obtemAparelho() async {
    // DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    this.aparelho = '';
  }
}
