class Report {
  String totalPollenCount;
  double temperature;
  String airQuality;

  Report({this.totalPollenCount, this.temperature, this.airQuality});

  Report.fromJson(Map<String, dynamic> parsedJson)
    : totalPollenCount = parsedJson['totalPollenCount'],
      temperature = parsedJson['currentTemperature'],
      airQuality = parsedJson['aqius'];
}
