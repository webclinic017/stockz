import 'dart:async';
import 'dart:developer' as dev;

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart' as base;
import 'package:stockz/setup.dart';

@LazySingleton()
class NoBodyLoggingInterceptor extends HttpLoggingInterceptor {
  NoBodyLoggingInterceptor() : super();

  @override
  FutureOr<Response> onResponse(Response response) {
    final base = response.base.request;
    chopperLogger.info("<-- ${response.statusCode} ${base!.url}");

    response.base.headers.forEach((String k, String v) => chopperLogger.info("$k: $v"));

    chopperLogger.info("--> END ${base.method}");
    return response;
  }
}

@LazySingleton()
class LoggingInterceptor extends HttpLoggingInterceptor {
  LoggingInterceptor() : super() {
    _setupLogging();
  }
}

void _setupLogging() {
  if (FlavorConfig.instance.environment == BuildEnvironment.production) {
    return;
  }
  final DateFormat fm = DateFormat("dd.MM HH:mm.ss");
  base.Logger.root.level = base.Level.ALL;
  base.Logger.root.onRecord.listen((event) {
    String message = event.message;
    if (message.length > 450000) {
      message = "CONTENT TOO LONG - TRUNCATING ${message.substring(0, 450000)}";
    }
    final String text = "${fm.format(event.time)}: $message";
    dev.log(text, name: "flutter");
  });
}
