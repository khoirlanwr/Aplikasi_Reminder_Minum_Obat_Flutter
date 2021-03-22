import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/blocs/reminder_bloc.dart';
import 'package:reminder_app/models/reminder_model.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModel reminderModel;

  ReminderCard({this.reminderModel});

  deleteReminder(BuildContext context) {
    Provider.of<ReminderBloc>(context, listen: false)
        .deleteData(this.reminderModel);
  }

  @override
  Widget build(BuildContext context) {
    var iconWidget = Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Image(
          width: 40,
          height: 40,
          image: AssetImage('assets/images/icons-alarm.png')),
    );

    var title = Text(
      this.reminderModel.dataTitle != null
          ? this.reminderModel.dataTitle
          : 'Untitled',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );

    var times = Text(
      this.reminderModel.dataTime != null
          ? this.reminderModel.dataTime
          : 'Undefined time',
      style: TextStyle(fontSize: 12, color: Colors.black45),
    );

    var description = Text(
      this.reminderModel.dataDesc != null
          ? this.reminderModel.dataDesc
          : 'Undefined Description',
      style: TextStyle(fontSize: 14),
    );

    var informationWidget = Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          SizedBox(height: 3),
          times,
          SizedBox(height: 7),
          description
        ],
      ),
    );

    var stackFirstChildren = GestureDetector(
      onTap: () {
        print('Reminder selected');
        Navigator.pushNamed(context, '/addReminder', arguments: reminderModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(children: [iconWidget, informationWidget]),
      ),
    );

    var buttonDelete = Positioned(
        right: 40.0,
        top: 20.0,
        child: GestureDetector(
          onTap: () {
            print('delete action');
            deleteReminder(context);
          },
          child: Icon(
            Icons.delete_rounded,
            color: Colors.red[400],
          ),
        ));

    return Stack(
      children: [stackFirstChildren, buttonDelete],
    );
  }
}
