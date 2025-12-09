import 'package:get/get.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class HomeController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  
  var isLoading = false.obs;
  var weatherData = Rxn<WeatherModel>();
  var forecastData = Rxn<ForecastModel>();
  
  // Manage multiple cities
  var savedCities = <String>['Amman', 'Irbid', 'Zarqa'].obs;
  var currentCityIndex = 0.obs;
  
  String get currentCity => savedCities[currentCityIndex.value];

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      isLoading.value = true;
      weatherData.value = await _weatherService.getCurrentWeather(currentCity);
      forecastData.value = await _weatherService.getForecast(currentCity);
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Failed to fetch weather data for $currentCity',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void switchCity(int index) {
    if (index >= 0 && index < savedCities.length) {
      currentCityIndex.value = index;
      fetchWeatherData();
    }
  }

  void addCity(String city) {
    if (city.isNotEmpty && !savedCities.contains(city)) {
      savedCities.add(city);
      Get.snackbar(
        'Success', 
        '$city added to your cities',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (savedCities.contains(city)) {
      Get.snackbar(
        'Info', 
        '$city is already in your list',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeCity(int index) {
    if (savedCities.length > 1) {
      String removedCity = savedCities[index];
      savedCities.removeAt(index);
      if (currentCityIndex.value >= savedCities.length) {
        currentCityIndex.value = savedCities.length - 1;
      }
      if (currentCityIndex.value == index) {
        fetchWeatherData();
      }
      Get.snackbar(
        'Removed', 
        '$removedCity removed from your cities',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error', 
        'You must have at least one city',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}