import 'package:ajex_track/models/google_map_models/lat_lng.dart';

import 'extra_info.dart';

class Legs {
  Legs({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.startLocation,
  });
  late final ExtraInfo distance;
  late final ExtraInfo duration;
  late final LatLng endLocation;
  late final LatLng startLocation;

  Legs.fromJson(Map<String, dynamic> json) {
    distance = ExtraInfo.fromJson(json['distance']);
    duration = ExtraInfo.fromJson(json['duration']);
    endLocation = LatLng.fromJson(json['end_location']);
    startLocation = LatLng.fromJson(json['start_location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['end_location'] = endLocation.toJson();
    _data['start_location'] = startLocation.toJson();
    return _data;
  }
}
