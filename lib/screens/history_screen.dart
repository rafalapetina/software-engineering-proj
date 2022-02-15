import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/helpers/dismiss_keyboard.dart';
import 'package:health_app/providers/user_provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history';

  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var attendance = AttendanceData.getData;
  var exam = ExamData.getData;
  var anamnese = '';
  var isDoctor = false;

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Atendimento",
                  icon: Icon(Icons.calendar_today),
                ),
                Tab(
                  text: "Exame",
                  icon: Icon(Icons.bar_chart_sharp),
                ),
              ],
            ),
            title: const Text('Histórico'),
          ),
          body: FutureBuilder(
            future: Firestore.instance.collection('consultas').getDocuments(),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : User.isDoc
                        ? _buildCard(attendance, attendance[0])
                        : TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return _buildCard(attendance,
                                      snapshot.data.documents[index].data);
                                },
                              ),
                              ListView.builder(
                                itemCount: exam.length,
                                itemBuilder: (context, index) {
                                  return _buildExamCard(exam[index]);
                                },
                              ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(data, snapshot) {
    return Card(
      elevation: 20,
      color: Colors.blueGrey[50],
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Dia ${snapshot['Horario']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !User.isDoc ?
                  'Dr. ${snapshot['Medico']} - ${snapshot['Especialidade']}':
                  '${snapshot['Medico']} - ${snapshot['Especialidade']}',
                  style: const TextStyle(color: Colors.blueGrey),
                ),
                Text('CRM 87654321'),
              ],
            ),
            leading: Icon(
              Icons.calendar_today,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              '${snapshot['Atendimento']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(snapshot['Local']),
            leading: Icon(
              Icons.gps_fixed,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text('Anamnese:'),
            subtitle: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: anamnese,
                  onChanged: (value) {
                    anamnese = value;
                  },
                ),
                if (User.isDoc)
                  ElevatedButton(
                    onPressed: () {
                      data['anamnese'] = anamnese;
                    },
                    child: Text('Confirmar'),
                  ),
              ],
            ),
            leading: Icon(
              Icons.dock_outlined,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(data) {
    return Card(
      elevation: 20,
      color: Colors.blueGrey[50],
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Dia ${data['date']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
                !User.isDoc
                    ? 'Dr. ${data['doctor']} - CRM ${data['crm']}'
                    : '${data['doctor']} - ${data['crm']}',
                style: const TextStyle(color: Colors.blueGrey)),
            leading: Icon(
              Icons.calendar_today,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('${data['exam']}'),
            leading: Icon(
              Icons.bar_chart_sharp,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text(
              '${data['address']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.gps_fixed,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    );
  }
}

class ExamData {
  static final getData = [
    {
      'date': '15/02/2022',
      'exam': 'Exame de Sangue',
      'doctor': 'Ricardo',
      'crm': '12345678',
      'address': 'Hospital Albert Eistein',
    }
  ];
}

class AttendanceData {
  static final getData = [
    {
      'Horario': '15/02/2021 18:30',
      'Medico': 'Paciente',
      'Especialidade': 'Rafael',
      'Atendimento': 'Presencial',
      'Local': '423 Creek Ave. Oshkosh, WI 54901',
      'anamnese': ''
    },
    // {
    //   'date': '20/05/2021',
    //   'doctor': 'Ana Paula',
    //   'crm': '12345432-6',
    //   'type': 'Online',
    //   'address': '',
    //   'anamnese':
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    // },
  ];
}
