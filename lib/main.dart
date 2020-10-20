import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'src/app.dart';
import 'dart:async';

void main() {
  final sentry = SentryClient(
      dsn:
          "http://1293e35debc34589b5f9470068634506:42268184a3454877a10e1dbf7034bcdb@ec2-18-188-88-3.us-east-2.compute.amazonaws.com/9");
  runZonedGuarded(
    () => runApp(AirPakApp()),
    (error, stackTrace) async {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );
  // runApp(App());
}
