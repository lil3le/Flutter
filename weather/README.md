# Weather App 🌤️

A modern, feature-rich weather application built with Flutter and GetX, providing real-time weather information and forecasts for multiple cities.

## 📱 Features

- **Multi-City Management**: Add, switch between, and manage multiple cities
- **Real-Time Weather Data**: Current temperature, humidity, wind speed, and weather conditions
- **5-Day Forecast**: Hourly weather predictions with visual icons
- **Beautiful UI**: Modern gradient design with smooth animations
- **City Navigation Bar**: Quick switching between saved cities with highlighted selection
- **Responsive Design**: Works seamlessly on web, mobile, and desktop platforms



## 🚀Setup

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.10.0 or higher)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/lil3le/Flutter
   cd Flutter/weather
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

   Or for web:
   ```bash
   flutter run -d chrome
   ```

## 🏗️ Project Structure

```
lib/
├── api/
│   ├── api_constant.dart          # API endpoints and keys
│   └── api_repository.dart        # API repository pattern
├── controller/
│   └── HomeController.dart        # GetX controller for state management
├── model/
│   └── weather_model.dart         # Data models for weather and forecast
├── pages/
│   └── home/
│       └── home_screen.dart       # Main weather screen
├── service/
│   └── weather_service.dart       # Weather API service
├── utils/
│   └── Binding/
│       └── HomeBinding.dart       # GetX bindings
├── widget/
│   ├── MyCard.dart               # Custom weather card widget
│   ├── myList.dart               # City list widget
│   └── my_chart.dart             # Forecast chart widget
└── main.dart                      # App entry point
```

## 🌐 API

This app uses the [OpenWeatherMap API](https://openweathermap.org/api) for weather data.

- Current Weather API: `/weather`
- 5 Day Forecast API: `/forecast`

## 💡 Key Features Implementation

### Multi-City Management
- Add cities via the `+` button in the app bar
- Switch cities by tapping on city chips in the navigation bar
- Remove cities using the three-dot menu on each city chip
- Minimum of one city required at all times

### State Management
- Built with **GetX** for reactive state management
- Efficient rebuilds using `Obx` widgets
- Centralized controller for weather data

### Weather Data
- Real-time weather updates
- Temperature in Celsius
- Weather icons from OpenWeatherMap
- 5-day forecast with 3-hour intervals

## 📝 Usage

1. **Adding a City**
   - Tap the `+` icon in the top-right corner
   - Enter the city name
   - Click "Add"

2. **Switching Cities**
   - Tap any city chip in the navigation bar
   - The app will fetch and display that city's weather

3. **Removing a City**
   - Click the three-dot menu (⋮) on any city chip
   - Select "Remove City"
   - Confirm the removal

4. **Refreshing Weather**
   - Tap the refresh icon in the top-right corner

