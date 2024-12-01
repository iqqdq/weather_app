import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/feauters/weather/data/model/response/response.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'http://api.weatherapi.com/v1/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  factory ApiClient.create({String? apiUrl}) {
    final dio = Dio();

    if (apiUrl != null) return ApiClient(dio, baseUrl: apiUrl);

    return ApiClient(dio);
  }

  @GET('current.json')
  Future<WeatherResponse> getWeather(
    @Query('key') String key,
    @Query('q') String q,
    @Query('aqi') String aqi,
  );
}
