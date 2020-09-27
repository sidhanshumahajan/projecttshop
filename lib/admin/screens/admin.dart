import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ktlabs/admin/db/brand.dart';
import 'package:ktlabs/admin/db/category.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController categoryTextController = TextEditingController();
  TextEditingController brandTextController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Pannel'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Product'),
            onTap: () {},
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
            title: Text('Add Category'),
            onTap: () {
              _categoryAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Category List'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Add Brand'),
            onTap: () {
              _brandAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.library_books_rounded),
            title: Text('Brand List'),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandTextController,
          validator: (value) {
            if (value.isEmpty) {
              return 'brand cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (brandTextController.text != null) {
                _brandService.createBrand(brandTextController.text);
              }
              Fluttertoast.showToast(msg: 'brand added');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryTextController,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(hintText: "add category"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (categoryTextController.text != null) {
                _categoryService..createCategory(categoryTextController.text);
              }
              Fluttertoast.showToast(msg: 'category added');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
