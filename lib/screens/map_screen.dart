import 'package:ajex_track/controllers/location_controller.dart';
import 'package:ajex_track/models/order.dart';
import 'package:ajex_track/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final Order order;
  const MapScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationController lc = Get.put(LocationController());
  late GoogleMapController mapController;
  late Marker orderMaker;
  late CameraPosition userLocationCamera;
  late CameraPosition orderLocationCamera;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    orderMaker = Marker(
      markerId: MarkerId('order_marker'),
      infoWindow: InfoWindow(title: widget.order.title),
      position: LatLng(widget.order.latitude, widget.order.longitude),
    );
    userLocationCamera = CameraPosition(
      target: LatLng(lc.latitude.value, lc.longitude.value),
      zoom: 19.151926040649414,
    );
    orderLocationCamera = CameraPosition(
      target: LatLng(widget.order.latitude, widget.order.longitude),
      zoom: 19.151926040649414,
    );
    _getPolyline();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.title),
        centerTitle: true,
        backgroundColor: Colors.green[300],
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Open Google Map?'),
                    content: Text('You will be directed to Google Map app'),
                    actions: [
                      TextButton(
                        onPressed: _launchURL,
                        child: Text('Open Google Map'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.map_outlined))
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: userLocationCamera,
        markers: {orderMaker},
        polylines: Set<Polyline>.of(polylines.values),
        onMapCreated: _onMapCreated,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDirection,
        label: Text('Show Directions'),
      ),
    );
  }

  _showDirection() {
    lc.startUpdatingLocation(onUpdate: (positon) {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(positon.latitude, positon.longitude), 20));
    });
  }

  _getPolyline() async {
    var directions = await LocationService.getDirections(
      myLocationLatitude: lc.latitude.value,
      myLocationLongitude: lc.longitude.value,
      orderLatitude: widget.order.latitude,
      orderLongitude: widget.order.longitude,
    );
    var route = directions.routes[0];
    var northeast =
        LatLng(route.bounds.northeast.lat, route.bounds.northeast.lng);
    var southwest =
        LatLng(route.bounds.southwest.lat, route.bounds.southwest.lng);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(northeast: northeast, southwest: southwest), 25));

    var points = polylinePoints
        .decodePolyline(directions.routes[0].overviewPolyline.points);

    if (points.isNotEmpty) {
      points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 2,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _launchURL() async {
    String _url = 'https://www.google.pl/maps/dir';
    String mylocationUrl = '/${lc.latitude.value},${lc.longitude.value}';
    String orderLocationUrl =
        '/${widget.order.latitude},${widget.order.longitude}';
    if (!await launch(_url + mylocationUrl + orderLocationUrl))
      throw 'Could not launch $_url';
  }
}
