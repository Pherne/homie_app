import 'package:flutter/material.dart';
import 'package:homie_app/controller/note_controller.dart';
import 'package:homie_app/views/notes_view.dart';

import 'package:provider/provider.dart';

class LaunchPad extends StatefulWidget {
  const LaunchPad({super.key});

  @override
  State<LaunchPad> createState() => _LaunchPadState();
}

class _LaunchPadState extends State<LaunchPad> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        children: [
          Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => NoteController(),
                      child: NotesView(),
                    ),
                  ),
                );
              },
              child: Text('Notizen'),
            ),
          )
        ],
      ),
    );
  }

// Widget _generateChild(Color color, IconData icon, String name) {
//   return Card(
//     color: color,
//     child: InkWell(
//       onTap: () {
//         switch (name) {
//           case 'Wetter':
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const WeatherView()));
//         }
//       },
//       child: name == 'Wetter'
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _selectWeatherIcon(),
//                 Text(context.watch<WeatherController>().description,
//                     style: TextStyle(fontSize: 20)),
//                 Text((context.watch<WeatherController>().temp).toString(),
//                     style: TextStyle(fontSize: 20))
//               ],
//             )
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   icon,
//                   size: 30,
//                 ),
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 20),
//                 )
//               ],
//             ),
//     ),
//   );
// }

// Widget _selectWeatherIcon() {
//   var weatherController = context.watch<WeatherController>();
//   var path = 'assets/icons/WeatherIcons/';
//
//   switch (weatherController.main) {
//     case 'Thunderstorm':
//       if (weatherController.currentWeather.weather.first.id == 212) {
//         return SvgPicture.asset('${path}strong_thunderstorms.svg');
//       } else if ([201, 202, 232, 211]
//           .contains(weatherController.currentWeather.weather.first.id)) {
//         return SvgPicture.asset('${path}isolated_thunderstorms.svg');
//       } else {
//         if (weatherController.isDay) {
//           return SvgPicture.asset(
//               '${path}isolated_scattered_thunderstorms_day.svg');
//         } else {
//           return SvgPicture.asset(
//               '${path}isolated_scattered_thunderstorms_night.svg');
//         }
//       }
//
//     case 'Drizzle':
//       return SvgPicture.asset('${path}drizzle.svg');
//
//     case 'Rain':
//       if ([502, 503, 504]
//           .contains(weatherController.currentWeather.weather.first.id)) {
//         return SvgPicture.asset('${path}heavy_rain.svg');
//       } else if ([520, 521, 522, 531]
//           .contains(weatherController.currentWeather.weather.first.id)) {
//         if (weatherController.isDay) {
//           return SvgPicture.asset('${path}scattered_showers_day.svg');
//         } else {
//           return SvgPicture.asset('${path}scattered_showers_night.svg');
//         }
//       } else if (weatherController.currentWeather.weather.first.id == 511) {
//         return SvgPicture.asset('${path}icy.svg');
//       } else {
//         return SvgPicture.asset('${path}showers_rain.svg');
//       }
//
//     case 'Snow':
//       if ([611, 612, 613, 615, 616]
//           .contains(weatherController.currentWeather.weather.first.id)) {
//         return SvgPicture.asset('${path}mixed_rain_snow.svg');
//       } else if ([602, 622]
//           .contains(weatherController.currentWeather.weather.first.id)) {
//         return SvgPicture.asset('${path}heavy_snow.svg');
//       } else if (weatherController.currentWeather.weather.first.id == 601) {
//         return SvgPicture.asset('${path}showers_snow.svg');
//       } else if (weatherController.currentWeather.wind.speed > 10.7) {
//         return SvgPicture.asset('${path}blizzard.svg');
//       } else {
//         if (weatherController.isDay) {
//           return SvgPicture.asset('${path}scattered_snow_showers_day.svg');
//         } else {
//           return SvgPicture.asset('${path}scattered_snow_showers_night.svg');
//         }
//       }
//
//     case 'Clouds':
//       {
//         if (weatherController.currentWeather.weather.first.id == 804) {
//           return SvgPicture.asset('${path}cloudy.svg');
//         } else {
//           if (weatherController.isDay) {
//             if (weatherController.currentWeather.weather.first.id == 803) {
//               return SvgPicture.asset('${path}mostly_cloudy_day.svg');
//             }
//             if (weatherController.currentWeather.weather.first.id == 802) {
//               return SvgPicture.asset('${path}partly_cloudy_day.svg');
//             }
//             return SvgPicture.asset('${path}mostly_clear_day.svg');
//           } else {
//             if (weatherController.currentWeather.weather.first.id == 803) {
//               return SvgPicture.asset('${path}mostly_cloudy_night.svg');
//             }
//             if (weatherController.currentWeather.weather.first.id == 802) {
//               return SvgPicture.asset('${path}partly_cloudy_night.svg');
//             }
//             return SvgPicture.asset('${path}mostly_clear_night.svg');
//           }
//         }
//       }
//
//     case 'Clear':
//       {
//         if (weatherController.isDay) {
//           return SvgPicture.asset('${path}clear_day.svg');
//         } else {
//           return SvgPicture.asset('${path}clear_night.svg');
//         }
//       }
//
//     case 'Squall':
//       return SvgPicture.asset('${path}windy.svg');
//
//     case 'Tornado':
//       return SvgPicture.asset('${path}tornado.svg');
//
//     case 'Mist':
//     case 'Smoke':
//     case 'Haze':
//     case 'Dust':
//     case 'Fog':
//     case 'Sand':
//     case 'Ash':
//       return SvgPicture.asset('${path}haze_fog_dust_smoke.svg');
//     default:
//       return Container();
//   }
// }
}
