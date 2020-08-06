import 'package:rxdart/rxdart.dart';
import '../models/report.dart';
import '../persistence/repository.dart';

class ReportBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of Report object and pass it to the UI screen as a stream.
  final _reportFetcher = PublishSubject<Report>();

  //This method is used to pass the response as stream to UI
  Stream<Report> get result => _reportFetcher.stream;

  fetchReport() async {
    Report reportResponse = await _repository.fetchReport();
    _reportFetcher.sink.add(reportResponse);
  }

  dispose() {
    //Close the result fetcher
    _reportFetcher.close();
  }
}

final reportBloc = ReportBloc();
