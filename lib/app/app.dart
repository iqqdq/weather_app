import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/core/string_constants.dart';
import 'package:weather_app/feauters/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/feauters/weather/domain/repository/weather_repository_interface.dart';
import 'package:weather_app/feauters/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/feauters/weather/presentation/view/weather_screen.dart';

class WeatherApp extends StatelessWidget {
  final ApiClient apiClient;

  const WeatherApp({
    super.key,
    required this.apiClient,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherRepositoryInterface>(
      create: (context) => WeatherRepositoryImpl(apiClient: apiClient),
      child: BlocProvider(
        create: (context) => WeatherBloc(
            weatherRepositoryInterface:
                context.read<WeatherRepositoryInterface>())
          ..add(WeatherFetchEvent(city: omsk)),
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: const WeatherScreen(),
        ),
      ),
    );
  }
}
