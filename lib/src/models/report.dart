class Report {
  String totalPollenCount;
  double temperature;
  int airQuality;

  Report({this.totalPollenCount, this.temperature, this.airQuality});
  
  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  Report.fromJson(Map<String, dynamic> parsedJson)
    : totalPollenCount = parsedJson['totalPollenCount'],
      temperature = checkDouble(parsedJson['currentTemperature']),
      airQuality = parsedJson['aqius'];
}
