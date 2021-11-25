import 'package:ajex_track/controllers/location_controller.dart';
import 'package:ajex_track/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final locationController = Get.put(LocationController());
  bool showLoadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                'Welecome To ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
              Text(
                'KEX',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.w300),
              ),
              Image.asset('assets/images/logistics.png'),
              SizedBox(
                height: 8,
              ),
              Text(
                'Deliver  Shipment',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 64),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showLoadingIndicator = true;
                      });
                      Geolocator.getCurrentPosition().then((position) {
                        locationController.latitude.value = position.latitude;
                        locationController.longitude.value = position.longitude;
                        Get.off(() => OrdersScreen());
                      });
                    },
                    child: showLoadingIndicator
                        ? CircularProgressIndicator(
                            color: Colors.green[50],
                          )
                        : Text(
                            'Show Orders',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
