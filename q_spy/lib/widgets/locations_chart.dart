import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_spy/models/location_chart_item.dart';
import 'package:http/http.dart' as http;

class LocationChart extends StatefulWidget {
  final String id;
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final String scale;
  LocationChart({this.id, this.label, this.startDate, this.endDate, this.scale});
  @override
  LocationChartState createState() {
    return new LocationChartState();
  }
}

class LocationChartState extends State<LocationChart>{
  List<DataPoint<double>> chartData = [DataPoint<double>(value: 0, xAxis: 0)];
  Future<List<DataPoint<double>>> futureData;
  DateTime nowDate = DateTime.now();
  List<double> hoursIndexes = [0.0];
  List<double> fiveminsIndexes = [];
  List<BezierLine> seriesLine = [];

  @override
  void didChangeDependencies() {
    futureData = getData();
    for(int i = 5; i < nowDate.hour; i++){
      hoursIndexes.add(i - 4.0);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context){
    double contentWidth = 0.0;
    //hoursIndexes = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0];
    fiveminsIndexes = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0];
    seriesLine.add(BezierLine(lineColor: Color(0xFFFFD055), data: chartData));
    String getXAxis(double index){
      if(widget.scale == "five"){
        switch(index.toString()){
          case "0.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":00";
          case "1.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":05";
          case "2.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":10";
          case "3.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":15";
          case "4.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":20";
          case "5.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":25";
          case "6.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":30";
          case "7.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":35";
          case "8.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":40";
          case "9.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":45";
          case "10.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":50";
          case "11.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":55";
          case "12.0": return (widget.startDate.hour + 1).toString().padLeft(2, '0') + ":00";
          default: return "";
        }
      }
      else{
        switch(index.toString()){
          case "0.0": return "06:00";
          case "1.0": return "07:00";
          case "2.0": return "08:00";
          case "3.0": return "09:00";
          case "4.0": return "10:00";
          case "5.0": return "11:00";
          case "6.0": return "12:00";
          case "7.0": return "13:00";
          case "8.0": return "14:00";
          case "9.0": return "15:00";
          case "10.0": return "16:00";
          case "11.0": return "17:00";
          case "12.0": return "18:00";
          case "13.0": return "18:00";
          case "14.0": return "19:00";
          case "15.0": return "20:00";
          case "16.0": return "21:00";
          case "17.0": return "22:00";
          default: return "";
        }
      }
    }

    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 16.0, right: 8.0, bottom: 8.0, left: 8.0),
        child: Text(widget.label,
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
              child: FutureBuilder<List<DataPoint<double>>>(
                future: futureData,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    contentWidth = widget.scale == "five" ? MediaQuery.of(context).size.width * 1.5 + widget.startDate.hour/10000 : MediaQuery.of(context).size.width * 2;
                    return BezierChart(
                      bezierChartScale: BezierChartScale.CUSTOM,
                      xAxisCustomValues: widget.scale == "five" ? fiveminsIndexes : hoursIndexes,
                      footerValueBuilder: getXAxis,
                      series: seriesLine,
                      config: BezierChartConfig(
                        contentWidth: contentWidth,
                        footerHeight: 40.0,
                        showVerticalIndicator: false,
                        verticalIndicatorFixedPosition: false,
                        backgroundColor: Color(0xFF00364F),
                        snap: true,
                        displayYAxis: true,
                        stepsYAxis: 5,
                        xAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 12),
                        yAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 12))
                    );
                  }
                  else{
                    return Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                          textAlign: TextAlign.center
                          )
                      ],
                    );
                  }
                },
              )
            ))
      ))
    ]);
  }
  Future<List<DataPoint<double>>> getData() async {
    Map<String, String> queryParameters = {
      'fechaInicio': widget.startDate.toString(),
      'IdLocacion': widget.id,
    };
    var uri = Uri.https('iot-backend-url.azurewebsites.net', '/api/reporte', queryParameters);
    final http.Response response = await http.get(uri, headers: { HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'});

    if (response.statusCode == 200){
      var jsonList = jsonDecode(response.body);
      for(int i = 5; i < nowDate.hour; i++){
        LocationDartTiem location = LocationDartTiem.fromJson(jsonList[i - 5]);
        chartData.add(DataPoint<double>(value: location.movimiento, xAxis: i - 5.0));
      }
      return chartData;
    }
    else{
      throw Exception('Failed to load data');
    }
  }
}
