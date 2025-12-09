import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/HomeController.dart';

class MyCard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weather = controller.weatherData.value;
      if (weather == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            image: AssetImage('assets/images/cloud-in-blue-sky.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Stack(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100, left: 20, right: 20),
              child: TextField(
                style: TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.addCity(value);
                  }
                },
                decoration: InputDecoration(
                  suffix: Icon(Icons.search, color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'SEARCH',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 1.0),
              child: SizedBox(
                height: 10,
                width: 10,
                child: OverflowBox(
                  minWidth: 0.0,
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 0.0,
                  maxHeight: (MediaQuery.of(context).size.height / 4),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weather.cityName.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'flutterfonts',
                              ),
                            ),
                            Text(
                              DateFormat('EEEE, MMMM d').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontFamily: 'flutterfonts',
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      weather.description,
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 22,
                                        fontFamily: 'flutterfonts',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${weather.temperature.round()}°C',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts',
                                      ),
                                    ),
                                    Text(
                                      'Feels like: ${weather.feelsLike.round()}°C',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                      ),
                                    ),
                                    Text(
                                      'Wind ${weather.windSpeed} m/s',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}