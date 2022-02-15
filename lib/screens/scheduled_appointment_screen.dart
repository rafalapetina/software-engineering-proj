import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/providers/user_provider.dart';

class ScheduledAppointmentScreen extends StatefulWidget {
  static const routeName = '/scheduledAppointment';

  _ScheduledAppointmentScreen createState() => _ScheduledAppointmentScreen();
}

class _ScheduledAppointmentScreen extends State<ScheduledAppointmentScreen> {
  var scheduled = User.isDoc ? ScheduledAppointmentData.getDocData : ScheduledAppointmentData.getData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultas Agendadas',
        ),
      ),
      body: ListView.builder(
        itemCount: scheduled.length,
        itemBuilder: (context, i) {
          var consulta = scheduled[i];
          return ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            subtitle: Text(consulta['type']),
            backgroundColor: Colors.cyan[50],
            title: Text(consulta['date'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(consulta['doctor'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                    if (User.isDoc) Text(consulta['meds']),
                    Text(consulta['where']),
                    ElevatedButton(
                        onPressed: () => scheduled.removeWhere((element) =>
                            element['doctor'] == consulta['doctor']),
                        child: Text('Cancelar Consulta')),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                height: 10,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              )
            ],
          );
        },
      ),
    );
  }
}

class ScheduledAppointmentData {
  static final getData = [
    {
      'date': 'Dia 15/03/2022 17:30',
      'type': 'Consulta médica',
      'doctor': 'Cardiologista - Dr Ricardo',
      'where': 'Consulta online - meet.google.com/wer-kgw-qws'
    },
    {
      'date': 'Dia 15/03/2022 18:30',
      'type': 'Consulta Médica',
      'doctor': 'Dermatologista - Dr Pedro',
      'where': '423 Creek Ave. Oshkosh, WI 54901'
    },
    // {
    //   'date': 'Dia 03/07/2022 20:30',
    //   'type': 'Consulta médica',
    //   'doctor': 'Endocrinologista - Dra Fernanda Melo',
    //   'where': 'Rua Prof. Alexandre Mendes, 70'
    // },
  ];
  static final getDocData = [
    {
      'date': 'Dia 15/03/2022 18:30',
      'type': 'Consulta online',
      'doctor': 'Paciente - Rafael',
      'meds': 'dipirona 2x dia',
      'where': '423 Creek Ave. Oshkosh, WI 54901'
    },
  ];
}
