import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/providers/appointment_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomPicker extends StatefulWidget {
  final String type;

  CustomPicker(this.type);

  @override
  CustomPickerState createState() => CustomPickerState();
}

class CustomPickerState extends State<CustomPicker> {
  var _selectedValue, _initialItem = 0;

  List<Widget> listTextValues = [];

  void _fillList(form) async {
    switch (widget.type) {
      case 'Especialidade':
        //ver especialidades cadastradas no campo de médicos
        var doctors =
            await Firestore.instance.collection('medicos').getDocuments();
        List<Widget> especialidades = [];
        doctors.documents.forEach((element) {
          var esp = element.data["especialidade"];
          if (especialidades.indexOf(Text(esp)) == -1)
            especialidades.add(Text(esp));
        });
        listTextValues = especialidades;
        listTextValues.insert(0, Text(''));
        break;
      case 'Medico':
        var doctorsCollection =
            await Firestore.instance.collection('medicos').getDocuments();
        Map<String, dynamic> availableDoctors = new Map();
        doctorsCollection.documents.forEach((element) {
          availableDoctors[element.data["especialidade"]] =
              element.data["nome"];
        });
        availableDoctors
            .removeWhere((key, value) => key != form['Especialidade']);
        listTextValues = Provider.of<AppointmentForm>(context, listen: false)
            .changeDoctors(availableDoctors.values.toList());
        listTextValues.insert(0, Text(''));
        break;
      case 'Atendimento':
        listTextValues = [
          Text('Online'),
          Text('Presencial'),
        ];
        break;
      case 'exame':
        listTextValues = [
          Text('Hemograma'),
          Text('Colesterol'),
          Text('Exame de Sangue'),
          Text('Ureia e Creatinina'),
          Text('Papanicolau'),
          Text('Glicemia'),
          Text('Exames de urina'),
        ];
        break;
      case 'solicitante':
         listTextValues = [
          Text('Ricardo - CRM 12345678'),
          Text('Pedro - CRM 87654321'),
        ];
        break;
      case 'hospital':
         listTextValues = [
          Text('Hospital Albert Einstein'),
          Text('Hospital São Luís'),
          Text('Alta Laboratóios'),
        ];
        break;
      case 'Local':
        listTextValues = [
          Text(''),
          Text('794 Foster Court Gainesville, VA 20155'),
          Text('423 Creek Ave. Oshkosh, WI 54901'),
          Text('66 Edgefield Drive Mebane, NC 27302'),
          Text('2 S. Glen Ridge Lane Chandler, AZ 85224'),
          Text('44 West Galvin Ave. Holly Springs, NC 27540'),
          Text('9644 Poor House Street Houston, TX 77016'),
        ];
        break;
      default:
        listTextValues = [];
    }
  }

  void _showPicker(BuildContext ctx, form) {
    var deviceSize = MediaQuery.of(ctx).size;

    //mostra widget para selecionar horario ou outro picker
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        width: deviceSize.width,
        height: deviceSize.height * 0.3,
        child: widget.type == 'Horario'
            ? CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                backgroundColor: Colors.white,
                onDateTimeChanged: (value) {
                  setState(() {
                    _selectedValue =
                        DateFormat('dd/MM/yyyy H:mm').format(value).toString();
                    Provider.of<AppointmentForm>(context, listen: false)
                        .changeForm(widget.type, _selectedValue);
                  });
                },
                use24hFormat: true,
                minimumYear: DateTime.now().year,
              )
            : CupertinoPicker(
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
                    Provider.of<AppointmentForm>(context, listen: false)
                        .changeForm(widget.type, _selectedValue.data);
                  });
                },
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<AppointmentForm>(context);
    final formData = form.items;
    //se a consulta é online o local não pode ser clicavel
    var disabled = Provider.of<AppointmentForm>(context).getValue('Atendimento') == 'Online' && widget.type == 'Local';


    _fillList(formData);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedValue != null
                ? Provider.of<AppointmentForm>(context).getValue(widget.type)
                : widget.type,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
        ],
      ),
      onPressed: () => disabled ? null : _showPicker(context, formData),
    );
  }
}
