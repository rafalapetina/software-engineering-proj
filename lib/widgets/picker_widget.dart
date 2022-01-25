import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPicker extends StatefulWidget {
  final String type;

  CustomPicker(this.type);

  @override
  CustomPickerState createState() => CustomPickerState();
}

class CustomPickerState extends State<CustomPicker> {
  var _selectedValue, _initialItem = 0;

  List<Widget> listTextValues = [];

  void _fillList() async {
    switch (widget.type) {
      case 'Especialidade':
        var medicos = await Firestore.instance.collection('medicos').getDocuments();
        print(medicos.documents);
        listTextValues = [
          Text('Online'),
          Text('Presencial'),
        ];
        break;
      case 'Atendimento':
        listTextValues = [
          Text('Online'),
          Text('Presencial'),
        ];
        break;
      default:
    }
  }

  void _showPicker(BuildContext ctx) {
    var deviceSize = MediaQuery.of(ctx).size;

    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        width: deviceSize.width,
        height: deviceSize.height * 0.3,
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          itemExtent: 30,
          magnification: 1.1,
          diameterRatio: 1,
          scrollController:
              FixedExtentScrollController(initialItem: _initialItem),
          children: listTextValues,
          onSelectedItemChanged: (value) {
            setState(() {
              _initialItem = value;
              _selectedValue = listTextValues[value];
              // print(_selectedValue);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fillList();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedValue != null
                ? _selectedValue.data
                : 'Escolha a especialidade',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
        ],
      ),
      onPressed: () => _showPicker(context),
    );
  }
}
