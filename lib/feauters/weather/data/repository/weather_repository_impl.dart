import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/feauters/weather/data/model/response/response.dart';

import '../../domain/repository/weather_repository_interface.dart';

class WeatherRepositoryImpl implements WeatherRepositoryInterface {
  WeatherRepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<FailureResponse, WeatherResponse>> fetchWeather({
    required String key,
    required String city,
  }) async {
    try {
      final response = await apiClient.getWeather(
        key,
        city,
        'no',
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(FailureResponse.fromJson(e.response?.data));
    }
  }
}
