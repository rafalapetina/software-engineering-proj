import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/widgets/picker_widget.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment';

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consulta Médica',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Especialidade',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            CustomPicker('Especialidade'),
            SizedBox(height: 20),
            Text(
              'Tipo de Atendimento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomPicker('Atendimento'),
          ],
        ),
      ),
    );
  }
}
