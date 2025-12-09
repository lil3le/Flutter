class Main_Weather {
  double? temp, feelsLike, tempMin, tempMax, pressure, humidity, sea_level, grnd_level;

  Main_Weather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.sea_level,
    this.grnd_level,
  });

  factory Main_Weather.fromJson(Map<String, dynamic> json) {
    return Main_Weather(
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
      "temp": this.temp,
      "feels_like": this.feelsLike,
      "temp_min": this.tempMin,
      "temp_max": this.tempMax,
      "pressure": this.pressure,
      "humidity": this.humidity,
      "sea_level": this.sea_level,
      "grnd_level": this.grnd_level,
    };
  }

}