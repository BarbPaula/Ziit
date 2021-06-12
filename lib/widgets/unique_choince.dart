import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UniqueChoinceWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String value;

  const UniqueChoinceWidget(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.value})
      : super(key: key);

  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<UniqueChoinceWidget> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    init();
  }

  init() {
    _dropDownValue = widget.value;
    setState(() {});
  }

  dynamic deleted;
  String _dropDownValue;

  List items = [
    "AC",
    "AL",
    "AM",
    "AP",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RO",
    "RS",
    "RR",
    "SC",
    "SE",
    "SP",
    "TO"
  ];

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
                  ? Text('ESTADO',
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
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString("uf", val);
                setState(() {
                  _dropDownValue = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
