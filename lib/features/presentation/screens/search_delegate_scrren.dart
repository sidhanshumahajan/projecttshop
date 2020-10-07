import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/screens/product_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate {
  final allData = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(children: [
      FutureBuilder(
          future: Provider.of<Products>(context, listen: false)
              .productSearch(query),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SpinKitPouringHourglass(
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              if (snapshot.error != null) {
                return Center(child: Text('Something wrong'));
              } else {
                return Consumer<Products>(
                    builder: (ctx, data, ch) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.searchedProducts.length == 0
                              ? 1
                              : data.searchedProducts.length,
                          itemBuilder: (ctx, index) => ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductListPage.routeName,
                                arguments:
                                    data.searchedProducts[index].category[0],
                              );
                            },
                            leading: Icon(Icons.restore),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.searchedProducts.length == 0
                                    ? 'No Result found'
                                    : data.searchedProducts[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ));
              }
            }
          }),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
