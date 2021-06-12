import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UniqueChoinceWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const UniqueChoinceWidget({
    Key key,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

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
    "1 Mês Gratuito",
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
                  ? Text('1 Mês gratuito',
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
              onChanged: (val) {
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
