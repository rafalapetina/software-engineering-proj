import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final form, snapshot, isFirstAcess;

  CustomDropdown(Map<String, dynamic> this.form, this.snapshot, this.isFirstAcess);

  @override
  Custom_DropdownState createState() => Custom_DropdownState();
}

class Custom_DropdownState extends State<CustomDropdown> {

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(child: Text("M"), value: "M"),
      DropdownMenuItem(child: Text("F"), value: "F"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var _selectedValue;
    if (!widget.isFirstAcess)
      _selectedValue = widget.snapshot.data['sexo'];

    return DropdownButtonFormField(
        items: dropdownItems,
        key: ValueKey('sex'),
        value: _selectedValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Sexo',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sexo inválido';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        onSaved: (value) {
          widget.form['sexo'] = value;
        });
  }
}
