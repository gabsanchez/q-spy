import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget{

  final DateFormat dateInputFormat;
  final DateTime defaultDate;
  final Function reload;
  final DateTime startDate;
  final DateTime endDate;
  final String scale;
  DatePicker(this.dateInputFormat, this.defaultDate, this.reload, this.scale, this.startDate, this.endDate);

  @override
  Widget build(BuildContext context){
    DateTime selectedDate = defaultDate;
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
          format: dateInputFormat,
          initialValue: DateTime.now(),
          readOnly: true,
          onChanged: (response) {
            selectedDate = response;
            reload(scale, DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startDate.hour, startDate.minute), DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endDate.hour, endDate.minute));
          },
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(2019),
                initialDate: selectedDate,
                lastDate: DateTime.now());
          }))
      );
  }
}