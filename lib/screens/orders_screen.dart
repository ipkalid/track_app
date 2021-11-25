import 'package:ajex_track/models/order.dart';
import 'package:ajex_track/widget/order_widget.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            for (int i = 0; i < 10; i++)
              OrderWidget(
                order: Order(
                  title: 'Order $i ',
                  latitude: 24.797458,
                  longitude: 46.741367,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
