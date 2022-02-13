import 'package:flutter/material.dart';
import 'package:health_app/screens/appointment_screen.dart';
import 'package:health_app/widgets/app_drawer_widget.dart';
import 'package:health_app/widgets/service_item.dart';
import 'package:health_app/screens/history_screen.dart';
import 'package:health_app/screens/exams_screen.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Serviços',
        ),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        children: [
          ServiceItem(
            'Agendar Consulta',
            'https://www.cabesp.com.br/images/assistenciaRapida/banner_telemedicina.jpg',
            AppointmentScreen.routeName,
          ),
          ServiceItem(
            'Agendar Exames',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR0zWtL6Zch_SCVqtkA4Wi19JYojRcRtStAA&usqp=CAU',
            ExamsScreen.routeName,
          ),
          ServiceItem(
            'Consultas Agendadas',
            'https://www.ventrix.com.br/wp/wp-content/uploads/2016/08/6-perguntas-e-respostas-sobre-a-telemedicina.jpeg',
            routeName,
          ),
          ServiceItem(
            'Histórico de Consultas',
            'https://1.bp.blogspot.com/-PA560uAt_Ks/XU8kNQQgpbI/AAAAAAAEEiE/jEltCrjqh-4T6yN9q9KkxorBIZBgNGcggCLcBGAs/s1600/projeto.png',
            HistoryScreen.routeName,
          ),
        ],
      ),
    );
  }
}
