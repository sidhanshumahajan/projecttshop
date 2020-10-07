import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/screens/admin/screens/brand_list_screen.dart';
import 'package:ktlabs/features/presentation/screens/admin/screens/category_list_screen.dart';
import 'package:ktlabs/services/brand.dart';
import 'package:ktlabs/services/category.dart';
import 'package:ktlabs/models/product.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:ktlabs/features/presentation/providers/check_authorization.dart';
import 'package:ktlabs/features/presentation/providers/gift_provider.dart';
import 'package:ktlabs/features/presentation/providers/order_provider.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/screens/add_product_screen.dart';
import 'package:ktlabs/features/presentation/screens/all_categories.dart';
import 'package:ktlabs/features/presentation/screens/auth_screen.dart';
import 'package:ktlabs/features/presentation/screens/cart_screen.dart';
import 'package:ktlabs/features/presentation/screens/gift_registry_screen.dart';
import 'package:ktlabs/features/presentation/screens/home_page.dart';
import 'package:ktlabs/features/presentation/screens/order_screen.dart';
import 'package:ktlabs/features/presentation/screens/product_detail_screen.dart';
import 'package:ktlabs/features/presentation/screens/product_list.dart';
import 'package:ktlabs/features/presentation/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
        ChangeNotifierProvider(create: (ctx) => CategoryService()),
        ChangeNotifierProvider(create: (ctx) => BrandService()),
        ChangeNotifierProvider(create: (ctx) => GiftProvider()),
        // ignore: missing_required_param
        ChangeNotifierProvider(create: (ctx) => Product()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.data != null) {
              return Authorization().checkAuthorization(context);
            } else {
              return AuthScreen();
            }
          },
        ),
        title: 'shopApp',
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          AllCategories.routeName: (ctx) => AllCategories(),
          WishListScreen.routeName: (ctx) => WishListScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          ProductListPage.routeName: (ctx) => ProductListPage(),
          BrandListScreen.routeName: (ctx) => BrandListScreen(),
          Homepage.routeName: (ctx) => Homepage(),
          CategoryListScreen.routeName: (ctx) => CategoryListScreen(),
          GiftRegistryScreen.routeName: (ctx) => GiftRegistryScreen(),
        },
      ),
    );
  }
}
