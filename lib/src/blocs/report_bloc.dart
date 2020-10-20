import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/report.dart';
import '../persistence/repository.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class ReportBloc {
  Repository _repository = Repository();

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String city;

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of Report object and pass it to the UI screen as a stream.
  final _reportFetcher = PublishSubject<Report>();

  //This method is used to pass the response as stream to UI
  Stream<Report> get result => _reportFetcher.stream;

  fetchReport() async {
    if (_locationData == null) {
      await this.getLocation();
    }
    Report reportResponse = await _repository.fetchReport(city, _locationData);
    _reportFetcher.sink.add(reportResponse);
  }

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      _locationData =
          await location.getLocation().timeout(const Duration(seconds: 2));
      if (_locationData != null) {
        getCityFromCoords(_locationData.latitude, _locationData.longitude);
      }
    } on TimeoutException catch (_) {
      // print('location could not be read $_err');
    }

    location.onLocationChanged.listen((LocationData currentLocation) async {
      if (currentLocation != null) {
        getCityFromCoords(currentLocation.latitude, currentLocation.longitude);
      }
      fetchReport();
    });
  }

  getCityFromCoords(lat, long) async {
    try {
      final coordinates = new Coordinates(lat, long);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      // print("${first.addressLine} : ${first.adminArea}");
      city = first.locality;
    } on Exception catch (_) {
      // print('never reached');
    }
  }

  dispose() {
    _reportFetcher.close();
  }
}

final reportBloc = ReportBloc();
