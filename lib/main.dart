import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/feauters/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feauters/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/feauters/weather/presentation/view/weather_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    final apiClient = ApiClient(dio);

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (context) => WeatherBloc(
            weatherRepositoryInterface:
                WeatherRepositoryImpl(apiClient: apiClient)),
        child: const WeatherScreen(),
      ),
    );
  }
}
