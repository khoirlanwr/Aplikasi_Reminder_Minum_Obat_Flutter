import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/blocs/reminder_bloc.dart';
import 'package:reminder_app/blocs/user_authentication.dart';
import 'package:reminder_app/models/reminder_model.dart';
import 'package:reminder_app/widgets/reminder_card.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _uid;

  // Exit account
  exitAccount() {
    userAuthentication.exitAccount();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var logoutButton = GestureDetector(
      onTap: () {
        exitAccount();
      },
      child: Container(
        width: 50.0,
        height: 40.0,
        child: Center(
          child: Text('Exit',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), color: Colors.red),
      ),
    );

    var navBar = Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [logoutButton],
      ),
    );

    var content = Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Text('Homepage Content', style: TextStyle(fontSize: 25)),
      ),
    );

    var retrieveData = Consumer<ReminderBloc>(
        builder: (context, reminder, child) =>
            FutureBuilder<List<ReminderModel>>(
              future: reminder.getLatestData(widget.user),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('State: waiting ...');
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  // print(snapshot.data.length);

                  List<ReminderModel> _resultedLists = snapshot.data;

                  if (_resultedLists == null) {
                    return Container(
                      child: Text('Hai, reminder masih kosong'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ReminderCard(
                            reminderModel: _resultedLists[index],
                          );
                        });
                  }
                }
              },
            ));

    var buttonAddReminder = Positioned(
        top: 20,
        left: 20,
        child: GestureDetector(
          onTap: () {
            print('button add reminder tapped');
            Navigator.pushNamed(context, '/addReminder', arguments: null);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image(image: AssetImage('assets/images/add-reminder.png')),
          ),
        ));

    var contentItems = Container(
      child: Column(children: [navBar, content, Expanded(child: retrieveData)]),
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [contentItems, buttonAddReminder],
        ),
      ),
    );
  }
}
