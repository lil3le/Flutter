import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/HomeController.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Weather', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.fetchWeatherData(),
          ),
          IconButton(
            icon: Icon(Icons.add_location_alt),
            onPressed: () => _showAddCityDialog(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          // City Navigation Bar
          _buildCityNavBar(controller),
          
          // Weather Content
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.weatherData.value == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No weather data available'),
                    ],
                  ),
                );
              }

              return _buildWeatherContent(context, controller);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCityNavBar(HomeController controller) {
    return Container(
      height: 60,
      color: Theme.of(Get.context!).primaryColor,
      child: Obx(() {
        final currentIndex = controller.currentCityIndex.value;
        
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemCount: controller.savedCities.length,
          itemBuilder: (context, index) {
            final isSelected = index == currentIndex;
            final city = controller.savedCities[index];
            
            return GestureDetector(
              onTap: () {
                controller.switchCity(index);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      city,
                      style: TextStyle(
                        color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : Colors.white,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_vert,
                        size: 18,
                        color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : Colors.white,
                      ),
                      onSelected: (value) {
                        if (value == 'remove' && controller.savedCities.length > 1) {
                          _showRemoveCityDialog(context, controller, index, city);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'remove',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 18),
                              SizedBox(width: 8),
                              Text('Remove City'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildWeatherContent(BuildContext context, HomeController controller) {
    final weather = controller.weatherData.value!;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Main Weather Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  weather.cityName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat('EEEE, MMM d').format(DateTime.now()),
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                      width: 120,
                      height: 120,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.temperature.round()}°',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          weather.description.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Weather Details Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildDetailCard(
                  Icons.thermostat,
                  'Feels Like',
                  '${weather.feelsLike.round()}°C',
                  Colors.orange,
                ),
                _buildDetailCard(
                  Icons.water_drop,
                  'Humidity',
                  '${weather.humidity}%',
                  Colors.blue,
                ),
                _buildDetailCard(
                  Icons.air,
                  'Wind Speed',
                  '${weather.windSpeed.toStringAsFixed(1)} m/s',
                  Colors.teal,
                ),
                _buildDetailCard(
                  Icons.wb_sunny,
                  'Temperature',
                  '${weather.temperature.round()}°C',
                  Colors.amber,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Forecast Section
          Obx(() {
            final forecast = controller.forecastData.value;
            if (forecast == null || forecast.items.isEmpty) {
              return SizedBox.shrink();
            }

            return Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                      SizedBox(width: 8),
                      Text(
                        '5-Day Forecast',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecast.items.length > 8 ? 8 : forecast.items.length,
                      itemBuilder: (context, index) {
                        final item = forecast.items[index];
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(item.dateTime),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                DateFormat('HH:mm').format(item.dateTime),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Image.network(
                                'https://openweathermap.org/img/wn/${item.icon}.png',
                                width: 40,
                                height: 40,
                              ),
                              Text(
                                '${item.temperature.round()}°',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCityDialog(BuildContext context, HomeController controller) {
    final TextEditingController textController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add City'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Enter city name',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                controller.addCity(textController.text.trim());
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showRemoveCityDialog(BuildContext context, HomeController controller, int index, String city) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove City'),
        content: Text('Do you want to remove $city from your cities?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.removeCity(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
}
