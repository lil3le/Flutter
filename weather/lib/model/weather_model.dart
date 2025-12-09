class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      feelsLike: (json['main']['feels_like'] - 273.15),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}

class ForecastModel {
  final List<ForecastItem> items;

  ForecastModel({required this.items});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    List<ForecastItem> items = (json['list'] as List)
        .map((item) => ForecastItem.fromJson(item))
        .toList();
    return ForecastModel(items: items);
  }
}

class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final String description;
  final String icon;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] - 273.15),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
