import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:ktlabs/features/presentation/providers/order_provider.dart';
import 'package:ktlabs/features/presentation/screens/components/cart_Items.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context);
    return Scaffold(
      appBar: new AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\u{20B9} ${cartItems.totalAmountOfCartItems.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  OrderButton(cartItems: cartItems)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cartItems.itemCount,
            itemBuilder: (ctx, int index) => CartItems(
              cartItems.items.values.toList()[index].id,
              cartItems.items.keys.toList()[index],
              cartItems.items.values.toList()[index].title,
              cartItems.items.values.toList()[index].price,
              cartItems.items.values.toList()[index].quantity,
            ),
          )),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartItems,
  }) : super(key: key);

  final Cart cartItems;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white60,
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cartItems.totalAmountOfCartItems <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cartItems.items.values.toList(),
                widget.cartItems.totalAmountOfCartItems,
              );
              Text('${widget.cartItems.items.values.toList()}');
              widget.cartItems.clearCart();
              setState(() {
                _isLoading = false;
              });
              Fluttertoast.showToast(msg: 'Order PLaced!!');
            },
    );
  }
}
