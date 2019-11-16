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
  List<DataPoint<double>> hoursChartData = [];
  List<DataPoint<double>> minutesChartData = [];
  DateTime nowDate = DateTime.now();
  List<double> hoursIndexes = [];
  List<double> fiveminsIndexes = [];
  List<BezierLine> seriesLine = [];
  BezierLine bezierLine;
  bool loadedData = false;

   StreamController<BezierLine> streamController = StreamController<BezierLine>();

    @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    loadedData = false;
    await getData();
    streamController.add(bezierLine);
    loadedData = true;
  }

  @override
  void didUpdateWidget(LocationChart oldWidget) {
    if(oldWidget.startDate.day != widget.startDate.day || oldWidget.startDate.hour != widget.startDate.hour){
      load();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    String getXAxis(double index){
      if(widget.scale == "five"){
        switch(index.toString()){
          case "0.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":05";
          case "1.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":10";
          case "2.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":15";
          case "3.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":20";
          case "4.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":25";
          case "5.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":30";
          case "6.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":35";
          case "7.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":40";
          case "8.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":45";
          case "9.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":50";
          case "10.0": return widget.startDate.hour.toString().padLeft(2, '0') + ":55";
          case "11.0": return (widget.startDate.hour + 1).toString().padLeft(2, '0') + ":00";
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
          case "13.0": return "19:00";
          case "14.0": return "20:00";
          case "15.0": return "21:00";
          case "16.0": return "22:00";
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
            child: StreamBuilder<BezierLine>(
                stream: streamController.stream,
                builder: (context, snapshot){
                  if(loadedData && snapshot.hasData && snapshot.data.data.length > 0 && (widget.scale == "five" ? fiveminsIndexes : hoursIndexes).length == snapshot.data.data.length){
                    //contentWidth = widget.scale == "five" ? MediaQuery.of(context).size.width * 1.5 + widget.startDate.hour/1000 : MediaQuery.of(context).size.width * 2 + widget.startDate.day/1000;
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0.0, right: 20.0, bottom: 0.0, left: 0.0),
                      child: BezierChart(
                        bezierChartScale: BezierChartScale.CUSTOM,
                        xAxisCustomValues: widget.scale == "five" ? fiveminsIndexes : hoursIndexes,
                        footerValueBuilder: getXAxis,
                        series: [snapshot.data],
                        config: BezierChartConfig(
                          displayLinesXAxis: true,
                          showDataPoints: true,
                          contentWidth: widget.scale == "five" ? MediaQuery.of(context).size.width * 2 + widget.startDate.hour/1000 : MediaQuery.of(context).size.width * 2.5 + widget.startDate.day/1000,
                          footerHeight: 30.0,
                          showVerticalIndicator: false,
                          verticalIndicatorFixedPosition: false,
                          backgroundColor: Color(0xFF00364F),
                          snap: true,
                          verticalIndicatorStrokeWidth: 0.0,
                          displayDataPointWhenNoValue: false,
                          pinchZoom: false,
                          displayYAxis: true,
                          stepsYAxis: 1,
                          xAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 14),
                          yAxisTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 14)
                        )
                      )
                    );
                  }
                  else{
                    return Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator()
                      ],
                    );
                  }
                },
              )
            ))
      )
    ]);
  }

  Future<BezierLine> getData() async {
    if(widget.scale == "five"){
      Map<String, String> queryParameters = {
        'IdLocacion': widget.id,
        'horaInicio': widget.startDate.toString()
      };
      var uri = Uri.https('iot-backend-url.azurewebsites.net', '/api/reporte', queryParameters);
      http.Response response = await http.get(uri, headers: { HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded, application/json'});
      if (response.statusCode == 200){
        var jsonList = jsonDecode(response.body);
        fiveminsIndexes = [];
        minutesChartData = [];
        for(int i = 0; i < jsonList.length; i++){
          jsonList[i]['hora'] = jsonList[i]['minuto'];
          fiveminsIndexes.add(i + 0.0);
          LocationDartTiem location = LocationDartTiem.fromJson(jsonList[i]);
          minutesChartData.add(DataPoint<double>(value: location.movimiento, xAxis: i + 0.0));
        }
        bezierLine = BezierLine(
          lineColor: Color(0xFFFFD055),
          data: minutesChartData
        );
        return bezierLine;
      }
      else{
        throw Exception('Failed to load data');
      }
    }
    else{
      Map<String, String> queryParameters = {
        'IdLocacion': widget.id,
        'fechaInicio': widget.startDate.toString()
      };
      var uri = Uri.https('iot-backend-url.azurewebsites.net', '/api/reporte', queryParameters);
      http.Response response = await http.get(uri, headers: { HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded, application/json'});

      if (response.statusCode == 200){
        var jsonList = jsonDecode(response.body);
        hoursIndexes = [];
        hoursChartData = [];
        for(int i = 0; i < jsonList.length; i++){
          hoursIndexes.add(i + 0.0);
          LocationDartTiem location = LocationDartTiem.fromJson(jsonList[i]);
          hoursChartData.add(DataPoint<double>(value: location.movimiento, xAxis: i + 0.0));
        }
        bezierLine = new BezierLine(
          lineColor: Color(0xFFFFD055),
          data: hoursChartData
        );
        return bezierLine;
      }
      else{
        throw Exception('Failed to load data');
      }
    }
  }
}
