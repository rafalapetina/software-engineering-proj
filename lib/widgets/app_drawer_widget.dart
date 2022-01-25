import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Services'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.person_alt_circle),
            title: Text(
              'Personal information',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/registerInfo');
            },
          ),
          Divider(
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
