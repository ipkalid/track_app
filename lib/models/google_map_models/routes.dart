import 'bound.dart';
import 'legs.dart';
import 'polyline.dart';

class Routes {
  Routes({
    required this.bounds,
    required this.legs,
    required this.overviewPolyline,
  });
  late final Bounds bounds;
  late final List<Legs> legs;
  late final OverviewPolyline overviewPolyline;

  Routes.fromJson(Map<String, dynamic> json) {
    bounds = Bounds.fromJson(json['bounds']);
    legs = List.from(json['legs']).map((e) => Legs.fromJson(e)).toList();
    overviewPolyline = OverviewPolyline.fromJson(json['overview_polyline']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bounds'] = bounds.toJson();
    _data['legs'] = legs.map((e) => e.toJson()).toList();
    _data['overview_polyline'] = overviewPolyline.toJson();
    return _data;
  }
}
