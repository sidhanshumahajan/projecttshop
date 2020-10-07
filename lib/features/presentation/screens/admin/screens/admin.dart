import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ktlabs/features/presentation/screens/admin/screens/brand_list_screen.dart';
import 'package:ktlabs/features/presentation/screens/admin/screens/category_list_screen.dart';
import 'package:ktlabs/services/brand.dart';
import 'package:ktlabs/services/category.dart';
import 'package:ktlabs/models/categories.dart';
import 'package:ktlabs/features/presentation/screens/add_product_screen.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  static const routeName = "/admin";
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController brandTextController = TextEditingController();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Pannel'),
      ),
      drawer: Drawer(
          child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new CircleAvatar(
            child: Text('A'),
          ),
          accountEmail: Text('admin@test.com'),
        ),
        FlatButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'))
      ])),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Product'),
            onTap: () {
              Navigator.of(context).pushNamed(AddProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.change_history),
            title: Text('Product List'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add MasterCategory'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => MasterCategoryAlert());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add SubCategory'),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => SubCategoryAlert());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add SubSubCategory'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => SubSubCategoryAlert());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Category List'),
            onTap: () {
              Navigator.of(context).pushNamed(CategoryListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Brand'),
            onTap: () {
              _brandAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Brand List'),
            onTap: () {
              Navigator.of(context).pushNamed(BrandListScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: brandTextController,
            validator: (value) {
              if (value.isEmpty) {
                return 'brand cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(hintText: "Add Brand"),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (brandTextController.text.isNotEmpty &&
                  _brandFormKey.currentState.validate()) {
                _brandService.createBrand(brandTextController.text);
                Fluttertoast.showToast(msg: 'brand added');
                Navigator.pop(context);
                brandTextController.text = '';
              }
            },
            child: Text('ADD')),
        FlatButton(
          onPressed: () {
            brandTextController.text = '';
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}

class MasterCategoryAlert extends StatefulWidget {
  @override
  _MasterCategoryAlertState createState() => _MasterCategoryAlertState();
}

class _MasterCategoryAlertState extends State<MasterCategoryAlert> {
  TextEditingController categoryTextController = TextEditingController();
  CategoryService _categoryService = CategoryService();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        autovalidate: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: categoryTextController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'category cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "add category"),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_categoryFormKey.currentState.validate()) {
                _categoryService
                    .createMasterCategory(categoryTextController.text);
                Fluttertoast.showToast(msg: 'Category added');
                Navigator.pop(context);
                categoryTextController.text = '';
              }
            },
            child: Text('ADD')),
        FlatButton(
          onPressed: () {
            categoryTextController.text = '';
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
  }
}

class SubCategoryAlert extends StatefulWidget {
  @override
  _SubCategoryAlertState createState() => _SubCategoryAlertState();
}

class _SubCategoryAlertState extends State<SubCategoryAlert> {
  TextEditingController categoryTextController = TextEditingController();
  CategoryService _categoryService = CategoryService();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  String _currentParentCategory = 'electronics';

  List<DropdownMenuItem<String>> getItem(List<CategoryModel> categories) {
    final List<DropdownMenuItem<String>> items = [];
    categories.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text('${element.name}'),
          value: element.name,
        ),
      );
    });
    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        autovalidate: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: categoryTextController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'category cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "add category"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: FutureBuilder(
                  future: Provider.of<CategoryService>(context, listen: false)
                      .getCategories(),
                  builder: (ctx, dataSnaphot) {
                    if (dataSnaphot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (dataSnaphot.error != null) {
                        return Text('Something Wrong');
                      } else {
                        return Consumer<CategoryService>(
                          builder: (ctx, data, _) => DropdownButton(
                            value: _currentParentCategory,
                            items: getItem(data.parentCategory),
                            onChanged: changeParentCategory,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_categoryFormKey.currentState.validate()) {
                _categoryService.createSubCategory(
                    categoryTextController.text, _currentParentCategory);
                Fluttertoast.showToast(msg: 'Category added');
                Navigator.pop(context);
                categoryTextController.text = '';
              }
            },
            child: Text('ADD')),
        FlatButton(
          onPressed: () {
            categoryTextController.text = '';
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
  }

  changeParentCategory(String selectedValue) {
    setState(() {
      _currentParentCategory = selectedValue;
    });
  }
}

class SubSubCategoryAlert extends StatefulWidget {
  @override
  _SubSubCategoryAlertState createState() => _SubSubCategoryAlertState();
}

class _SubSubCategoryAlertState extends State<SubSubCategoryAlert> {
  TextEditingController categoryTextController = TextEditingController();
  CategoryService _categoryService = CategoryService();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  String _currentParentCategory = 'electronics';
  String _currentChildCategory = 'Samsung';

  List<DropdownMenuItem<String>> getItem(List<CategoryModel> categories) {
    final List<DropdownMenuItem<String>> items = [];
    categories.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text('${element.name}'),
          value: element.name,
        ),
      );
    });
    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        autovalidate: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: categoryTextController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'category cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "add category"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: FutureBuilder(
                  future: Provider.of<CategoryService>(context, listen: false)
                      .getCategories(),
                  builder: (ctx, dataSnaphot) {
                    if (dataSnaphot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (dataSnaphot.error != null) {
                        return Text('Something Wrong');
                      } else {
                        return Consumer<CategoryService>(
                          builder: (ctx, data, _) => DropdownButton(
                            value: _currentParentCategory,
                            items: getItem(data.parentCategory),
                            onChanged: changeParentCategory,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: FutureBuilder(
                  future: Provider.of<CategoryService>(context, listen: false)
                      .getCategories(),
                  builder: (ctx, dataSnaphot) {
                    if (dataSnaphot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (dataSnaphot.error != null) {
                        return Text('Something Wrong');
                      } else {
                        return Consumer<CategoryService>(
                          builder: (ctx, data, _) => DropdownButton(
                            value: _currentChildCategory,
                            items: getItem(data.childCategory),
                            onChanged: changeChildCategory,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_categoryFormKey.currentState.validate()) {
                _categoryService.createSubSubCategory(
                    categoryTextController.text,
                    _currentParentCategory,
                    _currentChildCategory);
                Fluttertoast.showToast(msg: 'Category added');
                Navigator.pop(context);
                categoryTextController.text = '';
              }
            },
            child: Text('ADD')),
        FlatButton(
          onPressed: () {
            categoryTextController.text = '';
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
  }

  changeParentCategory(String selectedValue) {
    setState(() {
      _currentParentCategory = selectedValue;
    });
  }

  changeChildCategory(String selectedValue) {
    setState(() {
      _currentChildCategory = selectedValue;
    });
  }
}
