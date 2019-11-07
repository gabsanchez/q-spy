import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bezier_chart/bezier_chart.dart';
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
        body: MainContainer());
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     //Variables
    final DateTime startDate = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 05, 00);
    final DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 00);
    List<String> sampleHours = [
      "Todo el día",
      "06:00",
      "07:00",
      "08:00",
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00"
    ];
    final DateTime initialDate = DateTime.now();
    final List<DataPoint<DateTime>> sampleData = [
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 06, 00)),
      DataPoint<DateTime>(
          value: 10,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 07, 00)),
      DataPoint<DateTime>(
          value: 20,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 08, 00)),
      DataPoint<DateTime>(
          value: 30,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 09, 00)),
      DataPoint<DateTime>(
          value: 25,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 10, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 11, 00)),
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 12, 00)),
      DataPoint<DateTime>(
          value: 5,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 13, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 14, 00)),
      DataPoint<DateTime>(
          value: 18,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 15, 00)),
      DataPoint<DateTime>(
          value: 25,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 16, 00)),
      DataPoint<DateTime>(
          value: 13,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 17, 00)),
      DataPoint<DateTime>(
          value: 7,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 18, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 19, 00)),
      DataPoint<DateTime>(
          value: 20,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 20, 00)),
      DataPoint<DateTime>(
          value: 10,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 21, 00)),
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              initialDate.year, initialDate.month, initialDate.day, 22, 00))
    ];
    final dateInputFormat = DateFormat("dd/MM/yyyy");
    final List<LocationChart> locationsList = [];
    final LocationChart labT203 = new LocationChart(
      "LABORATORIO T-203",
      sampleData,
      startDate,
      endDate
    );
    final LocationChart labT204 = new LocationChart(
      "LABORATORIO T-204",
      sampleData,
      startDate,
      endDate
    );
    final LocationChart labG302 = new LocationChart(
      "LABORATORIO G-302",
      sampleData,
      startDate,
      endDate
    );

    locationsList.add(labT203);
    locationsList.add(labT204);
    locationsList.add(labG302);

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
              DatePicker(dateInputFormat, initialDate, locationsList),
              TimePicker(sampleHours, locationsList),
              labT203,
              labT204,
              labG302
            ]
          )
        )
      )
    );
  }
}