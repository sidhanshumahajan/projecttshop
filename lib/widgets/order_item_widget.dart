import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ktlabs/models/order_item.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orders;
  OrderItemWidget(this.orders);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.bounceInOut,
      height:
          _expanded ? min(widget.orders.products.length * 20.0 + 130, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
                title: Text('\u{20B9}${widget.orders.totalAmount}'),
                subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                    .format(widget.orders.orderDateTime)),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                )),

            // Container(
            AnimatedContainer(
              duration: Duration(
                milliseconds: 300,
              ),
              curve: Curves.bounceInOut,
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 4.0,
              ),
              //height:  min(widget.orders.products.length * 20.0 + 20, 100),
              height: _expanded
                  ? min(widget.orders.products.length * 20.0 + 20, 100)
                  : 0,
              child: ListView.builder(
                itemCount: widget.orders.products.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.orders.products.toList()[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.orders.products.toList()[index].quantity}x\u{20B9}${widget.orders.products.toList()[index].price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
