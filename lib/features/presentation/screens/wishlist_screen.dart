import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/widgets/whislist_widget.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Your WishList Collection'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false)
            .fetchWhislistProductOnly(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return AlertDialog(
                title: Text('An Error Occured !'),
                content: Text('Something went Wrong!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'),
                  ),
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(15.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Items in whislist',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          Consumer<Products>(
                              builder: (ctx, whistListItems, ch) => Chip(
                                    label: Text(
                                      '${whistListItems.totalNoOfwhislistItem}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  )),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<Products>(
                      builder: (ctx, data, child) => ListView.builder(
                        itemCount: data.favouriteProducts.length,
                        itemBuilder: (ctx, index) => WhislistWidget(
                          data.favouriteProducts[index].id,
                          data.favouriteProducts[index].title,
                          data.favouriteProducts[index].description,
                          data.favouriteProducts[index].price,
                          data.favouriteProducts[index].brand,
                          data.favouriteProducts.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
