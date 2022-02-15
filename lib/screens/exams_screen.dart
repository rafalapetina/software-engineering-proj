import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/widgets/picker_widget.dart';
import 'package:intl/intl.dart';

class ExamsScreen extends StatefulWidget {
  static const routeName = '/exams';

  @override
  _ExamsScreentate createState() => _ExamsScreentate();
}

class _ExamsScreentate extends State<ExamsScreen> {
  DateTime selectedDate = DateTime.now();
  final formattedDate = new DateFormat("dd-MM-yyyy");

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agendamento De Exame',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Nome do exame',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            CustomPicker('exame'),
            SizedBox(height: 20),
            Text(
              'Médico solicitante',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            CustomPicker('solicitante'),
            SizedBox(height: 20),
            Text(
              'Local do Exame',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            CustomPicker('hospital'),
            SizedBox(height: 20),
            Text(
              "Data do exame",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomPicker('Horario'),
            Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
    );
  }
}