import 'package:flutter/material.dart';
import 'package:ktlabs/services/brand.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class BrandListScreen extends StatelessWidget {
  static const routeName = "/brandScreen";
  Future<void> _callBrandServiceProvider(BuildContext context) async {
    await Provider.of<BrandService>(context, listen: false).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Available Brands',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _callBrandServiceProvider(context),
        builder: (ctx, dataSnaphot) {
          if (dataSnaphot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnaphot.error != null) {
              return Text('Something Wrong');
            } else {
              return Consumer<BrandService>(
                builder: (ctx, data, _) => ListView.builder(
                  itemCount: data.brand.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1.0,
                      color: RandomColor().randomColor(
                        colorBrightness: ColorBrightness.light,
                      ),
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '${data.brand[index].name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),
                    ),
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
