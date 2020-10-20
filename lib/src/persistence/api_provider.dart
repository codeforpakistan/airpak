import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' show Client;
import '../models/report.dart';
import 'package:sentry/sentry.dart';

class ApiProvider {
  final sentry = SentryClient(
      dsn:
          "http://1293e35debc34589b5f9470068634506:42268184a3454877a10e1dbf7034bcdb@ec2-18-188-88-3.us-east-2.compute.amazonaws.com/9");
  Client client = Client();
  Random random = new Random();

  Future<Report> fetchReport(String city, var _locationData) async {
    if (city == null || city == 'Rawalpindi') {
      city = 'Islamabad';
    }
    city = city.toLowerCase();
    print('Got city $city');
    final _baseUrl = "https://thawing-reef-17391.herokuapp.com" +
        "/air-pak/$city/${_locationData.latitude}/${_locationData.longitude}";
    // final _baseUrl = "http://localhost:3000" + "/air-pak/$city/${_locationData.latitude}/${_locationData.longitude}";
    print("baseUrl $_baseUrl");
    final response = await client.get(
        "$_baseUrl"); // Make the network call asynchronously to fetch the data.
    print(response.body.toString());
    sentry.capture(event: Event(message: '$_baseUrl | $city | $response'));
    if (response.statusCode == 200) {
      return Report.fromJson(
          json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
