import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/helpers/dismiss_keyboard.dart';

class MedicinesScreen extends StatefulWidget {
  static const routeName = '/medicines';

  _MedicinesScreenState createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  var medicines = MedicinesData.getData;
  var newMedical;
  static const showCard = true;

  _addMedical() {
    setState(() {
      if (newMedical != null) {
        medicines.add(Text(newMedical,
            style: const TextStyle(fontWeight: FontWeight.w500)));
      } else {
        print('é null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Meus Medicamentos',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Insira o novo medicamento:'),
                  onChanged: (text) {
                    newMedical = text;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: _addMedical,
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text(
                    'Adicionar Medicamento',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      return _buildCard(medicines[index]);
                    },
                  ),
                ),
              ],
            ),
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
            title: data,
          ),
        ],
      ),
    );
  }
}

class MedicinesData {
  static final getData = [
    // Text(
    //   'Decadron 2x dia',
    //   style: const TextStyle(fontWeight: FontWeight.w500),
    // ),
    // Text(
    //   'Paracetamol 1x dia',
    //   style: const TextStyle(fontWeight: FontWeight.w500),
    // ),
    // Text(
    //   'Nimesulida 3x dia',
    //   style: const TextStyle(fontWeight: FontWeight.w500),
    // ),
    // Text(
    //   'Acarbose 1x semana',
    //   style: const TextStyle(fontWeight: FontWeight.w500),
    // )
  ];
}
