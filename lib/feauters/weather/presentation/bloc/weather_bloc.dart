import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/feauters/weather/data/model/response/response.dart';
import 'package:weather_app/feauters/weather/domain/repository/weather_repository_interface.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositoryInterface _weatherRepositoryInterface;
  Timer? _timer;
  String city = omsk;

  WeatherBloc({required WeatherRepositoryInterface weatherRepositoryInterface})
      : _weatherRepositoryInterface = weatherRepositoryInterface,
        super(const WeatherLoadingState()) {
    on<WeatherFetchEvent>(_onFetchWeather);

    _timer = Timer.periodic(
      Duration(hours: 1),
      (_) => add(WeatherFetchEvent(city: city)),
    );
  }

  Future<void> _onFetchWeather(
    WeatherFetchEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoadingState());

    city = event.city;

    final result = await _weatherRepositoryInterface.fetchWeather(
      key: 'd62829a23f7b43fda37173712242911',
      city: city,
    );

    result.fold((l) => emit(WeatherFailureState(message: l.error.message)),
        (r) => emit(WeatherLoadedState(response: r)));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
