import 'package:ajex_track/controllers/location_controller.dart';
import 'package:ajex_track/models/order.dart';
import 'package:ajex_track/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    return Card(
      child: TextButton(
        onPressed: () => Get.to(() => MapScreen(order: order)),
        style: TextButton.styleFrom(primary: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                            'Distance: ${locationController.getDistance(order.latitude, order.longitude) ~/ 1000} km'),
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey[700],
              )
            ],
          ),
        ),
      ),
    );
  }
}
