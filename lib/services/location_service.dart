import 'dart:convert' as convert;
import 'package:ajex_track/models/google_map_models/directions.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static String _API = 'AIzaSyCyQ977_rDN4qP7jI_mFE5XxL_4urJBJfw';

  static Future<Directions> getDirections({
    required double myLocationLatitude,
    required double myLocationLongitude,
    required double orderLatitude,
    required double orderLongitude,
  }) async {
    var queryParams =
        'json?key=$_API&origin=$myLocationLatitude,$myLocationLongitude&destination=$orderLatitude,$orderLongitude';
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/$queryParams');

    print(url);
    var responds = await http.get(url);
    var json = convert.jsonDecode(responds.body);
    var directions = Directions.fromJson(json);
    return directions;
  }

  // Future<String> getPlaceId(String input) async {}
}
