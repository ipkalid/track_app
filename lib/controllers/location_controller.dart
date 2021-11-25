import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  LocationController() {
    getLocation();
  }

  var longitude = 0.0.obs;
  var latitude = 0.0.obs;
  StreamSubscription<Position>? streamPosition;

  double getDistance(double latitude, double longitude) {
    return Geolocator.distanceBetween(
        this.latitude.value, this.longitude.value, latitude, longitude);
  }

  void startUpdatingLocation({required void Function(Position) onUpdate}) {
    streamPosition = Geolocator.getPositionStream().listen((Position position) {
      updateLocation(position.latitude, position.longitude);
      onUpdate(position);
    });
  }

  void stopUpdatingLocation() {
    if (streamPosition != null) {
      streamPosition!.cancel();
    }
  }

  void updateLocation(double latitude, double longitude) {
    this.longitude.value = longitude;
    this.latitude.value = latitude;
    print('${longitude}, ${latitude}');
  }

  void checkPermission() async {
    var checkPermission = await Geolocator.checkPermission();

    switch (checkPermission) {
      case LocationPermission.always:
        getLocation();
        break;
      case LocationPermission.whileInUse:
        getLocation();
        break;
      case LocationPermission.denied:
        Get.defaultDialog(
          title: 'Denied Location',
          content: Text(
            'This is a sample Content',
          ),
        );
        break;
      case LocationPermission.deniedForever:
        Get.defaultDialog(
          title: 'Denied Location',
          content: Text(
            'This is a sample Content',
          ),
        );
        break;
    }
  }

  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  getLocation() async {
    var position = await Geolocator.getCurrentPosition();
    longitude.value = position.longitude;
    latitude.value = position.latitude;
    print('${longitude}, ${latitude}');
  }
}
