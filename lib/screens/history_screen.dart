import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/screens/attendance_data.dart';
import 'package:health_app/screens/exam_data.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history';

  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var attendance = AttendanceData.getData;
  var exam = ExamData.getData;

  static const showCard = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Atendimento", icon: Icon(Icons.calendar_today)),
                Tab(text: "Exame", icon: Icon(Icons.health_and_safety)),
              ],
            ),
            title: const Text('Histórico'),
            backgroundColor: Colors.red,
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    return _buildCard(attendance[index]);
                  }),
              ListView.builder(
                  itemCount: exam.length,
                  itemBuilder: (context, index) {
                    return _buildExamCard(exam[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(data) {
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
            subtitle: Text('Dr. ${data['doctor']} - CRM ${data['crm']}',
                style: const TextStyle(color: Colors.blueGrey)),
            leading: Icon(
              Icons.calendar_view_month_outlined,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              '${data['type']}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('${data['address']}'),
            leading: Icon(
              Icons.gps_fixed,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text('Anamnese:'),
            subtitle: Text('${data['anamnese']}'),
            leading: Icon(
              Icons.document_scanner_outlined,
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
            subtitle: Text('Dr. ${data['doctor']} - CRM ${data['crm']}',
                style: const TextStyle(color: Colors.blueGrey)),
            leading: Icon(
              Icons.calendar_view_month_outlined,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('${data['exam']}'),
            leading: Icon(
              Icons.health_and_safety_sharp,
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
