class Wind {
  double? speed, deg, gust;

  Wind({
    this.speed,
    this.deg, 
    this.gust
  });

  Map<String, dynamic> toJson() => {
    'speed': speed,
    'deg': deg,
    'gust': gust,
  };

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: double.parse(json["speed"]),
      deg: json["deg"],
      gust: json["gust"],
    );
  }

}