class LocationDartTiem{
  double movimiento;
  DateTime hora;

  LocationDartTiem(this.movimiento, this.hora);

  factory LocationDartTiem.fromJson(Map<String, dynamic> parsedJson){
    return LocationDartTiem(
      double.parse(parsedJson['movimiento'].toString()),
      DateTime.parse(parsedJson['hora'])
    );
  }
}