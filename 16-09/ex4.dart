import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(MaterialApp(home: CalendarScreen()));
}


class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int days = DateTime(now.year, now.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(title: Text("Calendário")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemCount: days,
        itemBuilder: (context, index) {
          int day = index + 1;
          DateTime date = DateTime(now.year, now.month, day);

          return TextButton(
            child: Text("$day"),
            onPressed: () {
              String weekday = DateFormat.EEEE('pt_BR').format(date);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DayScreen(weekday, day),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DayScreen extends StatelessWidget {
  final String weekday;
  final int day;

  DayScreen(this.weekday, this.day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dia")),
      body: Center(
        child: Text(
          "$weekday - $day",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
