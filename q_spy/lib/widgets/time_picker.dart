import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'locations_chart.dart';

class TimePicker extends StatelessWidget{
  final List<String> hours;
  final List<LocationChart> locationsList;
  TimePicker(this.hours, this.locationsList);
  @override
  Widget build(BuildContext context){
    CarouselSlider hoursSlider = CarouselSlider(
    height: 40.0,
    viewportFraction: 0.99,
    autoPlay: false,
    enlargeCenterPage: false,
    items: hours.map(
      (hour) {
        return Container(
          width: 200.0,
          padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Color(0xFFCEDDF4),
            border: Border.all( color: Color(0xFF00364F) ),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: Text(
            hour,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          )
        );
      }
    ).toList(),
  );
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            width: 40.0,
            padding: EdgeInsets.all(0),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0)
              ),
              onPressed: () => hoursSlider.previousPage(
                duration: Duration(milliseconds: 1),
                curve: Curves.easeIn
              ),
              color: Color(0xFF00364F),
              child: Icon(
                Icons.arrow_left,
                color: Color(0xFFCEDDF4),
                size: 40.0
              )
            ),
          ),
          Container(
            child: hoursSlider,
            constraints: BoxConstraints(
              maxWidth: 200.0,
              minWidth: 200.0
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            width: 40.0,
            child: RaisedButton(
              padding: EdgeInsets.symmetric(),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0)
              ),
              onPressed: () => hoursSlider.nextPage(
                duration: Duration(milliseconds: 1),
                curve: Curves.easeIn
              ),
              color: Color(0xFF00364F),
              child: Icon(
                Icons.arrow_right,
                color: Color(0xFFCEDDF4),
                size: 40.0
              )
            ),
          )
        ],
      )
    );
  }
}