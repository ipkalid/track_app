import 'package:ajex_track/models/google_map_models/routes.dart';

class Directions {
  Directions({
    required this.routes,
  });
  late final List<Routes> routes;

  Directions.fromJson(Map<String, dynamic> json) {
    routes = List.from(json['routes']).map((e) => Routes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['routes'] = routes.map((e) => e.toJson()).toList();
    return _data;
  }
}
