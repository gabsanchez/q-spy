import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:bezier_chart/bezier_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
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
    final startDate = new DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 05, 00);
    final endDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 00);
    final dateInputFormat = DateFormat("yyyy-MM-dd");
    var selectedDate = DateTime.now();
    final sampleData = [
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 06, 00)),
      DataPoint<DateTime>(
          value: 10,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 07, 00)),
      DataPoint<DateTime>(
          value: 20,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 08, 00)),
      DataPoint<DateTime>(
          value: 30,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 09, 00)),
      DataPoint<DateTime>(
          value: 25,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 10, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 11, 00)),
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 12, 00)),
      DataPoint<DateTime>(
          value: 5,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 13, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 14, 00)),
      DataPoint<DateTime>(
          value: 18,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 15, 00)),
      DataPoint<DateTime>(
          value: 25,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 16, 00)),
      DataPoint<DateTime>(
          value: 13,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 17, 00)),
      DataPoint<DateTime>(
          value: 7,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 18, 00)),
      DataPoint<DateTime>(
          value: 15,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 19, 00)),
      DataPoint<DateTime>(
          value: 20,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 20, 00)),
      DataPoint<DateTime>(
          value: 10,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 21, 00)),
      DataPoint<DateTime>(
          value: 0,
          xAxis: new DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day, 22, 00))
    ];
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFCEDDF4)
        ),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new DatePicker(selectedDate: selectedDate, dateInputFormat: dateInputFormat),
                      new LocationChart(
                          label: "LABORATORIO T-203",
                          data: sampleData,
                          startDate: startDate,
                          endDate: endDate),
                      new LocationChart(
                          label: "LABORATORIO T-204",
                          data: sampleData,
                          startDate: startDate,
                          endDate: endDate),
                      new LocationChart(
                          label: "LABORATORIO G-302",
                          data: sampleData,
                          startDate: startDate,
                          endDate: endDate),
                    ]))));
  }
}

class DatePicker extends StatelessWidget{
  DateFormat _dateInputformat;
  DateTime _selectedDate;
  DatePicker({
    DateFormat dateInputFormat,
    DateTime selectedDate
  }){
    _dateInputformat = dateInputFormat;
    _selectedDate = selectedDate;
  }
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 26.0, right: 50.0, bottom: 8.0, left: 50.0),
      child: Material(
        type: MaterialType.button,
        color: Color(0xFF00364F),
        borderRadius: BorderRadius.circular(50.0),
        textStyle: TextStyle(
          color: Colors.white
        ),
        child: DateTimeField(
          decoration: InputDecoration(
            border: InputBorder.none
          ),
          style: TextStyle(
            color: Colors.white
          ),
          resetIcon: null,
          textAlign: TextAlign.center,
          format: _dateInputformat,
          initialValue: DateTime.now(),
          readOnly: true,
          onChanged: (response) {
            _selectedDate = response;
          },
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(2019),
                initialDate: _selectedDate,
                lastDate: DateTime.now());
          }))
      );
  }
}

class LocationChart extends StatelessWidget {
  String _label;
  List<DataPoint<DateTime>> _data;
  DateTime _startDate;
  DateTime _endDate;
  LocationChart(
      {String label,
      List<DataPoint<DateTime>> data,
      DateTime startDate,
      DateTime endDate}) {
    _label = label;
    _data = data;
    _startDate = startDate;
    _endDate = endDate;
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 16.0, right: 8.0, bottom: 8.0, left: 8.0), child: Text(_label,
        style: TextStyle(
          color: Color(0xFF00364F),
          fontSize: 20,
          fontFamily: "Quicksand-Semibold"
        ))),
      Center(
        child: Card(
        clipBehavior: Clip.hardEdge,
        color: Color(0xFF00364F),
        child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 0.0, right: 20.0, bottom: 0.0, left: 0.0),
              child: BezierChart(
                bezierChartScale: BezierChartScale.HOURLY,
                fromDate: _startDate,
                toDate: _endDate,
                series: [BezierLine(lineColor: Color(0xFFFFD055), data: _data)],
                config: BezierChartConfig(
                    footerHeight: 40,
                    showVerticalIndicator: false,
                    verticalIndicatorFixedPosition: false,
                    backgroundColor: Color(0xFF00364F),
                    snap: false,
                    displayYAxis: true,
                    stepsYAxis: 5,
                    xAxisTextStyle:
                        TextStyle(color: Colors.blueGrey, fontSize: 12),
                    yAxisTextStyle:
                        TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ),
            )),
      ))
    ]);
  }
}
