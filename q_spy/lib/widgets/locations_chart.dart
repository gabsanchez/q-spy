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
  List<double> hoursIndexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
  List<double> fiveminsIndexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  List<DataPoint<double>> otherSampleData = [
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
    DataPoint<double>(value: 7, xAxis: 12)
  ];

  List<DataPoint<double>> sampleData = [
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

  String getXAxis(index){
    if(widget.scale == "five"){
      switch(index.toString()){
        case "0.0": return "0" + widget.startDate.hour.toString() + ":00";
        case "1.0": return "0" + widget.startDate.hour.toString() + ":05";
        case "2.0": return "0" + widget.startDate.hour.toString() + ":10";
        case "3.0": return "0" + widget.startDate.hour.toString() + ":15";
        case "4.0": return "0" + widget.startDate.hour.toString() + ":20";
        case "5.0": return "0" + widget.startDate.hour.toString() + ":25";
        case "6.0": return "0" + widget.startDate.hour.toString() + ":30";
        case "7.0": return "0" + widget.startDate.hour.toString() + ":35";
        case "8.0": return "0" + widget.startDate.hour.toString() + ":40";
        case "9.0": return "0" + widget.startDate.hour.toString() + ":45";
        case "10.0": return "0" + widget.startDate.hour.toString() + ":50";
        case "11.0": return "0" + widget.startDate.hour.toString() + ":55";
        case "12.0": return "0" + (widget.startDate.hour + 1).toString() + ":00";
        default: return "0";
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
        default: return "0";
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
              child: BezierChart(
                bezierChartScale: BezierChartScale.CUSTOM,
                xAxisCustomValues: widget.scale == "five" ? fiveminsIndexes : hoursIndexes,
                //fromDate: startDate,
                //toDate: endDate,
                footerValueBuilder: getXAxis,
                series: [BezierLine(lineColor: Color(0xFFFFD055), data: widget.scale == "five" ? otherSampleData : sampleData)],
                config: BezierChartConfig(
                    contentWidth: MediaQuery.of(context).size.width * 2,
                    footerHeight: 40,
                    showVerticalIndicator: false,
                    verticalIndicatorFixedPosition: false,
                    backgroundColor: Color(0xFF00364F),
                    snap: true,
                    displayYAxis: true,
                    stepsYAxis: 5,
                    xAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 12),
                    yAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 12))
              ),
            )),
      ))
    ]);
  }
}
