import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/screens/cart_screen.dart';
import 'package:ktlabs/features/presentation/screens/components/product_grid.dart';
import 'package:ktlabs/features/presentation/screens/search_delegate_scrren.dart';
import 'package:ktlabs/features/presentation/widgets/badge.dart';
import 'package:ktlabs/features/presentation/widgets/drawer.dart';
import 'package:ktlabs/features/presentation/widgets/horizontal_list_view.dart';
import 'package:ktlabs/features/presentation/widgets/image_carosuel.dart';
import 'package:ktlabs/features/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(),
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cartData, ch) => Badge(
              child: ch,
              color: Colors.red,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //image Carosuel start here
            imageCarosuel,
            //padding between carosuel and text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Category'),
              ),
            ),
            // categories list view start here
            HorizontalListView(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Recent Products'),
              ),
            ),
            Container(
              height: 130,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ProductsGrid(),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 15.0, top: 12.0, left: 5.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Featured Products'),
              ),
            ),
            Consumer<Products>(
              builder: (ctx, data, _) => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.items.length,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                  value: data.items[index],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 9.0, left: 9.0, right: 9.0),
                    child: ProductCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
