import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' show Client;
import '../models/report.dart';

class ApiProvider {
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

    if (response.statusCode == 200) {
      return Report.fromJson(
          json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
