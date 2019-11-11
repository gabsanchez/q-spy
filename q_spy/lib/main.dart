import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:q_spy/widgets/date_picker.dart';
import 'package:q_spy/widgets/locations_chart.dart';
import 'package:q_spy/widgets/time_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QSpy",
      theme: ThemeData(
        primaryColor: Color(0xFF00364F),
        highlightColor: Color(0xFF00364F),
        primaryColorLight: Color(0xFFCEDDF4)
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QSPY"),
          toolbarOpacity: 0.0,
          bottomOpacity: 0.0,
          backgroundColor: Color(0xFFCEDDF4),
          centerTitle: true,
          elevation: 1.0,
          textTheme: TextTheme(title: TextStyle(
            fontFamily: "Quicksand-Bolder",
            fontSize: 26
            )),
        ),
        body: MainContainer(
          "hour",
          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00),
          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 00)
        )
      );
  }
}

class MainContainer extends StatefulWidget{
  final String scale;
  final DateTime startDate;
  final DateTime endDate;

  MainContainer(this.scale, this.startDate, this.endDate);
  @override
  State<StatefulWidget> createState() {
    return new MainContainerState(scale: scale, startDate: startDate, endDate: endDate);
  }

}
class MainContainerState extends State<MainContainer> {
  String scale;
  DateTime startDate;
  DateTime endDate;
  MainContainerState({this.scale, this.startDate, this.endDate});

  reload(newScale, newStartDate, newEndDate){
    this.setState((){
      scale = newScale;
      startDate = newStartDate;
      endDate = newEndDate;
    });
  }
  @override
  Widget build(BuildContext context) {
     //Variables
    DateTime initialDate = DateTime.now();
    DateFormat dateInputFormat = DateFormat("dd/MM/yyyy");

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFCEDDF4)
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePicker(dateInputFormat, initialDate, reload, scale),
              TimePicker(startDate, endDate, reload),
              LocationChart(
                id: "1",
                label: "LABORATORIO T-203",
                startDate: startDate,
                endDate: endDate,
                scale: scale
              )
            ]
          )
        )
      )
    );
  }
}