import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/feauters/weather/data/model/entity/entity.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final Location location;
  final Current current;

  WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
