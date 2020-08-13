import '../models/report.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<Report> fetchReport(String city, var _locationData) => appApiProvider.fetchReport(city, _locationData);
}
