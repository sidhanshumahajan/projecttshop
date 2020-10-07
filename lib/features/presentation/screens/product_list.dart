import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:ktlabs/models/product.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/widgets/category_based_product_card.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/productList";
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: new AppBar(
          title: Text('Products'),
        ),
        body: FutureBuilder(
            future: Provider.of<Products>(context, listen: false)
                .fetchProducts(category),
            builder: (ctx, dataSnaphot) {
              if (dataSnaphot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnaphot.error != null) {
                  return Center(child: Text('Something Wrong'));
                } else {
                  return Consumer<Products>(
                      builder: (ctx, data, _) => Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  createBreadCrumb(data.categoryBaseProducts),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.categoryBaseProducts.length,
                              itemBuilder: (ctx, int index) =>
                                  ChangeNotifierProvider.value(
                                value: data.categoryBaseProducts[index],
                                child: CategoryBasedProductCard(),
                              ),
                            ))
                          ]));
                }
              }
            }));
  }

  Widget createBreadCrumb(List<Product> categoryBaseProducts) {
    Widget result;
    categoryBaseProducts.forEach((element) {
      result = BreadCrumb(items: <BreadCrumbItem>[
        BreadCrumbItem(
            content: Text(
          'Home',
        )),
        BreadCrumbItem(
            content: Text(
          element.category[0],
        )),
        BreadCrumbItem(
            content: Text(
          element.category[1],
        )),
      ], divider: Icon(Icons.chevron_right));
    });
    return result;
  }
}
