import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/order_provider.dart';
import 'package:ktlabs/features/presentation/widgets/drawer.dart';
import 'package:ktlabs/features/presentation/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        // a technique to do things without making stateful widget
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Center(child: Text('Oops! Something Went wrong')),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, allOrders, child) => ListView.builder(
                  itemCount: allOrders.orders.length,
                  itemBuilder: (ctx, int index) => OrderItemWidget(
                    allOrders.orders[index],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
