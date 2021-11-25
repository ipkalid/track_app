class OverviewPolyline {
  OverviewPolyline({
    required this.points,
  });
  late final String points;

  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['points'] = points;
    return _data;
  }
}
