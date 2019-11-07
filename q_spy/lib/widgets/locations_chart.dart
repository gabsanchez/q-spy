import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationChart extends StatefulWidget {
  final String label;
  final List<DataPoint<DateTime>> data;
  final DateTime startDate;
  final DateTime endDate;
  LocationChart(this.label, this.data, this.startDate, this.endDate);
  @override
  LocationChartState createState() {
    return new LocationChartState(label, data, startDate, endDate);
  }
}

class LocationChartState extends State<LocationChart>{
  String label;
  DateTime startDate;
  DateTime endDate;
  List<DataPoint<DateTime>> data;

  LocationChartState(this.label, this.data, this.startDate, this.endDate);

  @override
  Widget build(BuildContext context){
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 16.0, right: 8.0, bottom: 8.0, left: 8.0), child: Text(label,
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
                fromDate: startDate,
                toDate: endDate,
                series: [BezierLine(lineColor: Color(0xFFFFD055), data: data)],
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
