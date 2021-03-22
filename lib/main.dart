import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/blocs/reminder_bloc.dart';
import 'package:reminder_app/blocs/user_authentication.dart';
import 'package:reminder_app/screens/add_reminder_page.dart';
import 'package:reminder_app/screens/home_page.dart';
import 'package:reminder_app/screens/landing_page.dart';
import 'package:reminder_app/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() {
    print('[INITIAL FIREBASE COMPLETED]');
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthentication()),
        ChangeNotifierProvider(create: (context) => ReminderBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminder App',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
        ),
        // home: LandingPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/addReminder': (context) => AddReminderPage()
        },
      ),
    );
  }
}
