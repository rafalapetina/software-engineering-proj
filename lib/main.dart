import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/helpers/custom_route.dart';
import 'package:health_app/providers/appointment_provider.dart';
import 'package:health_app/screens/appointment_screen.dart';
import 'package:health_app/screens/auth_screen.dart';
import 'package:health_app/screens/pre_register_screen.dart';
import 'package:health_app/screens/register_info_screen.dart';
import 'package:health_app/screens/services_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AppointmentForm(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Color.fromRGBO(6, 37, 36, 1),
            accentColor: Colors.deepOrange,
            fontFamily: 'Poppins',
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.red,
              textTheme: ButtonTextTheme.primary,
              disabledColor: Colors.red[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                elevation: 5,
                minimumSize: Size(150, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            })),
        // home: ServicesScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            // return PreRegister();
            if (userSnapshot.hasData) {
              return ServicesScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
        routes: {
          RegisterInfo.routeName: (ctx) => RegisterInfo(),
          PreRegister.routeName: (ctx) => PreRegister(),
          ServicesScreen.routeName: (ctx) => ServicesScreen(),
          AppointmentScreen.routeName: (ctx) => AppointmentScreen(),
        },
      ),
    );
  }
}
