import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/providers/appointment_provider.dart';
import 'package:health_app/screens/services_screen.dart';
import 'package:health_app/widgets/picker_widget.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment';

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  _trySubmit() async {
    var _form = Provider.of<AppointmentForm>(context, listen: false).items;
    for (var key in _form.keys) {
      var value = _form[key];
      if (value == '' && key != 'Local') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content:
                Text('Preencha todos os campos!', textAlign: TextAlign.center),
          ),
        );
        return;
      }
    }
    _form['usuarioId'] = FirebaseAuth.instance.currentUser().toString();
    Firestore.instance.collection('consultas').document().setData(_form);
    Navigator.of(context).pushReplacementNamed(ServicesScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consulta Médica',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              //
              Text(
                'Médico',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              CustomPicker('Medico'),
              SizedBox(height: 20),

              Text(
                'Tipo de Atendimento',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              CustomPicker('Atendimento'),
              SizedBox(height: 20),

              Text(
                'Local de Atendimento',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              CustomPicker('Local'),
              SizedBox(height: 20),

              Text(
                'Data e horário da consulta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              CustomPicker('Horario'),
              SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  onPressed: _trySubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40),
                  ),
                  child: Text(
                    'Agendar',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
