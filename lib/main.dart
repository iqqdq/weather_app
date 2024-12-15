import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/app/app.dart';

void main() {
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printRequestData: false,
        printResponseHeaders: false,
        printResponseMessage: true,
        printResponseData: true,
        requestPen: AnsiPen()..blue(),
        responsePen: AnsiPen()..green(),
        errorPen: AnsiPen()..red(),
      ),
    ),
  );

  runApp(WeatherApp(apiClient: ApiClient(dio)));
}
