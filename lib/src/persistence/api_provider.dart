import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' show Client;
import '../models/report.dart';

class ApiProvider {
  Client client = Client();
  Random random = new Random();

  Future<Report> fetchReport() async {
    int randomNumber = random.nextInt(100) + 1;
    final _baseUrl = "https://jsonplaceholder.typicode.com/albums/$randomNumber";
    print("baseUrl $_baseUrl");
    final response = await client.get("$_baseUrl"); // Make the network call asynchronously to fetch the data.
    print(response.body.toString());

    if (response.statusCode == 200) {
      return Report.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }
}