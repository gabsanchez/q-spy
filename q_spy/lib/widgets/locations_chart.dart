import 'dart:async';
import 'dart:math';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationChart extends StatefulWidget {
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final String scale;
  LocationChart({this.label, this.startDate, this.endDate, this.scale});
  @override
  LocationChartState createState() {
    return new LocationChartState();
  }
}

class LocationChartState extends State<LocationChart>{

  


  @override
  Widget build(BuildContext context){
    List<double> hoursIndexes = [];
    List<double> fiveminsIndexes = [];
    List<DataPoint<double>> otherSampleData = [];
    List<DataPoint<double>> sampleData = [];
    List<BezierLine> seriesLine = [];
    double contentWidth = 0.0;
    hoursIndexes = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0];
    fiveminsIndexes = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0];
    otherSampleData = [
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 0),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 1),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 2),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 3),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 4),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 5),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 6),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 7),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 8),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 9),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 10),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 11),
      DataPoint<double>(value: double.parse(Random().nextInt(30).toString()), xAxis: 12)
    ];

    sampleData = [
      DataPoint<double>(value: 0, xAxis: 0),
      DataPoint<double>(value: 10, xAxis: 1),
      DataPoint<double>(value: 20, xAxis: 2),
      DataPoint<double>(value: 30, xAxis: 3),
      DataPoint<double>(value: 25, xAxis: 4),
      DataPoint<double>(value: 15, xAxis: 5),
      DataPoint<double>(value: 0, xAxis: 6),
      DataPoint<double>(value: 5, xAxis: 7),
      DataPoint<double>(value: 15, xAxis: 8),
      DataPoint<double>(value: 18, xAxis: 9),
      DataPoint<double>(value: 25, xAxis: 10),
      DataPoint<double>(value: 13, xAxis: 11),
      DataPoint<double>(value: 7, xAxis: 12),
      DataPoint<double>(value: 15, xAxis: 13),
      DataPoint<double>(value: 20, xAxis: 14),
      DataPoint<double>(value: 10, xAxis: 15),
      DataPoint<double>(value: 7, xAxis: 16),
      DataPoint<double>(value: 0, xAxis: 17)
    ];
    seriesLine.add(BezierLine(lineColor: Color(0xFFFFD055), data: widget.scale == "five" ? otherSampleData : sampleData));
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
              child: Builder(
                builder: (context){
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
                },
              )
            ))
      ))
    ]);
  }
}
