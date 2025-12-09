import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/controller/HomeController.dart';
import 'package:weather/model/weather_model.dart';

class MyChart extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final forecast = controller.forecastData.value;
      if (forecast == null || forecast.items.isEmpty) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text('No forecast data')),
          ),
        );
      }

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries<ForecastItem, String>>[
              SplineSeries<ForecastItem, String>(
                dataSource: forecast.items,
                xValueMapper: (ForecastItem f, _) =>
                    '${f.dateTime.hour}:00',
                yValueMapper: (ForecastItem f, _) =>
                    f.temperature,
              ),
            ],
          ),
        ),
      );
    });
  }
}