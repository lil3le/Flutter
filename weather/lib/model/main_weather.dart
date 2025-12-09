class MainWeather {
  double? temp, feelsLike, tempMin, tempMax, pressure, humidity, sea_level, grnd_level;

  MainWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.sea_level,
    this.grnd_level,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: double.parse(json["temp"]),
      feelsLike: json["feels_like"],
      tempMin: json["temp_min"],
      tempMax: json["temp_max"],
      pressure: json["pressure"],
      humidity: json["humidity"],
      sea_level: json["sea_level"],
      grnd_level: json["grnd_level"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temp": temp,
      "feels_like": feelsLike,
      "temp_min": tempMin,
      "temp_max": tempMax,
      "pressure": pressure,
      "humidity": humidity,
      "sea_level": sea_level,
      "grnd_level": grnd_level,
    };
  }

}