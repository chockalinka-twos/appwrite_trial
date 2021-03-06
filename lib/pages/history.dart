import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twos_appwrite_trial/data/model/water_intake.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int todaysIntake = 0;
  List<WaterIntake> intakes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMEd().format(
            DateTime.now(),
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                ...intakes.map((intake) {
                  return ListTile(
                    title: Text("${intake.amount} ml"),
                    subtitle: Text(
                        "${DateFormat.yMMMMd().format(intake.date)} ${DateFormat.jm().format(intake.date)}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        //delete
                      },
                    ),
                  );
                })
              ],
            ),
    );
  }
}
