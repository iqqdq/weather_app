part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class WeatherLoadedState extends WeatherState {
  const WeatherLoadedState({required this.response});

  final WeatherResponse response;

  @override
  List<Object> get props => [response];
}

final class WeatherFailureState extends WeatherState {
  const WeatherFailureState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
