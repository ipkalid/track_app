class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });
  late final Bound northeast;
  late final Bound southwest;

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = Bound.fromJson(json['northeast']);
    southwest = Bound.fromJson(json['southwest']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['northeast'] = northeast.toJson();
    _data['southwest'] = southwest.toJson();
    return _data;
  }
}

class Bound {
  Bound({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Bound.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}
