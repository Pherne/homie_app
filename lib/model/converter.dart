// import 'package:homie_app/model/serializing_json/weather/weather.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// class Converter {
//   static DateTime dateFromUnixTime(int unixTime) =>
//       DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
//
//   static bool isSunUp(String sunState) => sunState=='above_horizon';
// }
//
// class WeatherConverter implements JsonConverter<Weather, Map<String, dynamic>> {
//   @override
//   Weather fromJson(Map<String, dynamic> json) {
//     var list = json as List<Map<String, dynamic>>;
//     var weatherJson =
//         list.where((e) => e['entity_id'] == 'weather.dresden_stadt')
//             as Map<String, dynamic>;
//     var sunJson =
//         list.where((e) => e['entity_id'] == 'sun.sun') as Map<String, dynamic>;
//     var precipitationJson = list.where((e) =>
//         e['entity_id'] ==
//         'sensor'
//             '.dresden_stadt_precipitation_probability') as Map<String, dynamic>;
//     var weatherAttributes = weatherJson['attributes'];
//
//     var finalJson = <String, dynamic>{
//       'state': weatherJson['state'],
//       'temperature': weatherAttributes['temperature'],
//       'humidity': weatherAttributes['humidity'],
//       'uv_index': weatherAttributes['uv_index'],
//       'wind_bearing': weatherAttributes['wind_bearing'],
//       'wind_speed': weatherAttributes['wind_speed'],
//       'visibility': weatherAttributes['visibility'],
//       'icon': weatherAttributes['icon'],
//       'precipitation': precipitationJson['state'],
//       'sun_up': sunJson['state'],
//     };
//
//     return Weather.fromJson(finalJson);
//   }
//
//   @override
//   Map<String, dynamic> toJson(Weather object) {
//     throw UnimplementedError();
//   }
// }
