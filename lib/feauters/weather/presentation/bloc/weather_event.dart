part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class WeatherFetchEvent extends WeatherEvent {
  const WeatherFetchEvent({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}
