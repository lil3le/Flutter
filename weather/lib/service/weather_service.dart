import 'package:dio/dio.dart';
import 'package:weather/api/api_constant.dart';
import 'package:weather/model/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();

  Future<WeatherModel> getCurrentWeather(String city) async {
    try {
      final response = await _dio.get(
        '${ApiConstant.baseUrl}${ApiConstant.weatherEndpoint}',
        queryParameters: {
          'q': city,
          'appid': ApiConstant.apiKey,
        },
      );
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  Future<ForecastModel> getForecast(String city) async {
    try {
      final response = await _dio.get(
        '${ApiConstant.baseUrl}${ApiConstant.forecastEndpoint}',
        queryParameters: {
          'q': city,
          'appid': ApiConstant.apiKey,
        },
      );
      return ForecastModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load forecast data: $e');
    }
  }
}