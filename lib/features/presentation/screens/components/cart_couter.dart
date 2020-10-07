import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatefulWidget {
  final String productId;
  final double price;
  final String title;
  CartCounter(this.productId, this.price, this.title);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int noOfItems = 1;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    incrementValue() {
      setState(() {
        noOfItems++;
      });
    }

    decrementValue() {
      setState(() {
        if (noOfItems == 1) {
          noOfItems = 1;
        }
        noOfItems--;
      });
    }

    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
          height: 38,
          child: OutlineButton(
            child: Icon(Icons.remove),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            onPressed: noOfItems == 1
                ? null
                : () {
                    cart.reduceProductQunatityOnlyByOne(widget.productId);
                    decrementValue();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You have reduced the item count'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$noOfItems'.padLeft(2, '0')),
        ),
        SizedBox(
          width: 50,
          height: 38,
          child: OutlineButton(
            child: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            onPressed: () {
              cart.addItem(widget.productId, widget.price, widget.title);
              incrementValue();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('You have increase the item count'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
