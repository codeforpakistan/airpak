class Report {
  String totalPollenCount;
  double temprature;
  String airQuality;

  Report({this.totalPollenCount, this.temprature, this.airQuality});

  Report.fromJson(Map<String, dynamic> parsedJson)
    : totalPollenCount = parsedJson['totalPollenCount'],
      temprature = parsedJson['currentTemperature'],
      airQuality = parsedJson['airQuality'];

}