import 'package:flutter/material.dart';
import 'package:ktlabs/services/category.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class CategoryListScreen extends StatelessWidget {
  static const routeName = "/categoryListScreen";
  Future<void> _callCategoryServiceProvider(BuildContext context) async {
    await Provider.of<CategoryService>(context, listen: false)
        .fetchAllCategoriesName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Available Categories',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _callCategoryServiceProvider(context),
        builder: (ctx, dataSnaphot) {
          if (dataSnaphot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnaphot.error != null) {
              return Text('Something Wrong');
            } else {
              return Consumer<CategoryService>(
                builder: (ctx, data, _) => ListView.builder(
                  itemCount: data.allCategories.length,
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
                          '${data.allCategories[index]}',
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
