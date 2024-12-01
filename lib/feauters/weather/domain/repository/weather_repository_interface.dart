import 'package:dartz/dartz.dart';

import '../../data/model/response/response.dart';

abstract interface class WeatherRepositoryInterface {
  Future<Either<FailureResponse, WeatherResponse>> fetchWeather({
    required String key,
    required String city,
  });
}
