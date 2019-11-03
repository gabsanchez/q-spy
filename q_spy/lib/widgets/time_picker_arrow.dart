import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_spy/widgets/time_control.dart';

class TimePickerArrow extends StatelessWidget{
  final String direction;
  final TimeControl timeControl;
  TimePickerArrow(this.direction, this.timeControl );
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        print(direction);
        if(direction == "right"){
          timeControl.index += 1;
        }
        else{
          timeControl.index -= 1;
        }
      },
      clipBehavior: Clip.hardEdge,
      autofocus: false,
      color: Color(0xFFCEDDF4),
      splashColor: Color(0xFFCEDDF4),
      elevation: 0.0,
      child: Material(
        type: MaterialType.circle,
        color: Color(0xFF00364F),
        child: arrowIcon()
      )
    );
  }

  Widget arrowIcon(){
    if(direction == "right"){
      return Icon(
        Icons.arrow_right,
        color: Colors.white,
        size: 40.0
      );
    }
    return Icon(
        Icons.arrow_left,
        color: Colors.white,
        size: 40.0
      );
  }
}