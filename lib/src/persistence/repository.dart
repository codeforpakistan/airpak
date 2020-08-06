import '../models/report.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<Report> fetchReport() => appApiProvider.fetchReport();
}
