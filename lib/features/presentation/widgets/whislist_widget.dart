import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WhislistWidget extends StatelessWidget {
  final String id;
  final String title;
  final String desc;
  final double price;
  final String brand;
  int totalItemsCount;
  WhislistWidget(
    this.id,
    this.title,
    this.desc,
    this.price,
    this.brand,
    this.totalItemsCount,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10.0),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you Sure?'),
            content: Text('Do you want to remove item from cart?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('NO')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('YES')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Products>(context, listen: false)
            .removeItemFromWhisList(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text('\u{20B9}$price'),
                  ),
                ),
              ),
              title: Text(title),
            )),
      ),
    );
  }
}
