import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkti_app_aventura/views/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sistema.dart';

Sistema sistema = Sistema();

class UniqueChoinceWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function setValues;

  const UniqueChoinceWidget(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.setValues})
      : super(key: key);

  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<UniqueChoinceWidget> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  dynamic deleted;
  String _dropDownValue;

  List items = [
    "1 vez ao dia",
    "2 vez ao dia",
    "3 vez ao dia",
    "4 vez ao dia",
    "5 vez ao dia",
  ];

  updateUser(x) async {
    try {
      Dio dio = new Dio();

      var d = int.parse(x.substring(0, 1));

      widget.setValues(d);

      print(d);

      Response response = await dio.put(
          "http://barbara.marciomkt.com.br/mkti_ziit/api/public/v1/api/usuarios/update",
          data: {
            "00_cod": "265",
            "00_nome": "teste_api_update 5",
            "00_email": "testeapiupdategmail.com",
            "x_vezes": d
          });

      print(response);
    } catch (e) {
      if (e.response.data[0]['`f02_loginUsuario`(?,?,?)'] == 3) {
        print("error");
      }
    }
  }

  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(88, 89, 91, 1),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            padding: EdgeInsets.all(4.5),
            child: DropdownButton(
              underline: SizedBox(),
              hint: _dropDownValue == null
                  ? Text('X Vezes ao dia',
                      style: TextStyle(color: Color.fromRGBO(150, 151, 154, 1)))
                  : Text(
                      _dropDownValue,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
              isExpanded: true,
              iconSize: 40.0,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Color(0xffCBFF00),
              ),
              style: TextStyle(fontSize: 19.0, color: Colors.black),
              items: items.map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) async {
                setState(() {
                  _dropDownValue = val;
                });
                updateUser(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
