import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktlabs/services/brand.dart';
import 'package:ktlabs/services/category.dart';
import 'package:ktlabs/models/brands.dart';
import 'package:ktlabs/models/categories.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = "/addProduct";
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleEditingController = new TextEditingController();
  TextEditingController _priceEditingController = new TextEditingController();
  TextEditingController _descEditingController = new TextEditingController();

  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = 'electronics';
  String _currentChildCategory = 'Laptops';
  String _currentBrand = 'Levis';
  final picker = ImagePicker();
  bool _isLoading = false;
  File _img1;
  File _img2;
  File _img3;

  @override
  void initState() {
    super.initState();
  }

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

  List<DropdownMenuItem<String>> getBrandItem(List<BrandModel> brands) {
    final List<DropdownMenuItem<String>> items = [];
    brands.forEach((element) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.7),
                                  width: 2.0),
                              onPressed: () {
                                _uploadImage(
                                    picker.getImage(
                                        source: ImageSource.gallery),
                                    1);
                              },
                              child: _displayIndividualImage1(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.7),
                                  width: 2.0),
                              onPressed: () {
                                _uploadImage(
                                    picker.getImage(
                                        source: ImageSource.gallery),
                                    2);
                              },
                              child: _displayIndividualImage2(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.7),
                                  width: 2.0),
                              onPressed: () {
                                _uploadImage(
                                    picker.getImage(
                                        source: ImageSource.gallery),
                                    3);
                              },
                              child: _displayIndividualImage3(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Enter the Product Title in the below field',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: true,
                        controller: _titleEditingController,
                        decoration: InputDecoration(hintText: 'Product name'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'Please enter a valid product name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: true,
                        controller: _priceEditingController,
                        decoration: InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater than Zero.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: true,
                        controller: _descEditingController,
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a description.';
                          }
                          if (value.length < 10) {
                            return 'Description should be atleast 10 character long';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                          child: FutureBuilder(
                              future: Provider.of<CategoryService>(context,
                                      listen: false)
                                  .getCategories(),
                              builder: (ctx, dataSnaphot) {
                                if (dataSnaphot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (dataSnaphot.error != null) {
                                    return Center(
                                        child: Text('Something Wrong'));
                                  } else {
                                    return Consumer<CategoryService>(
                                      builder: (ctx, data, _) => DropdownButton(
                                        value: _currentCategory,
                                        items: getItem(data.parentCategory),
                                        onChanged: changeCategory,
                                      ),
                                    );
                                  }
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                          child: FutureBuilder(
                              future: Provider.of<CategoryService>(context,
                                      listen: false)
                                  .getCategories(),
                              builder: (ctx, dataSnaphot) {
                                if (dataSnaphot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (dataSnaphot.error != null) {
                                    return Center(
                                        child: Text('Something Wrong'));
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
                              }),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                          child: Text(
                            'Brands',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                          child: FutureBuilder(
                            future: Provider.of<BrandService>(context,
                                    listen: false)
                                .getBrands(),
                            builder: (ctx, dataSnaphot) {
                              if (dataSnaphot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (dataSnaphot.error != null) {
                                  return Center(child: Text('Something Wrong'));
                                } else {
                                  return Consumer<BrandService>(
                                    builder: (ctx, data, _) => DropdownButton(
                                      value: _currentBrand,
                                      items: getBrandItem(data.brand),
                                      onChanged: changeBrand,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _isLoading
                          ? null
                          : RaisedButton(
                              elevation: 2,
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              child: Text('Save Product'),
                              onPressed: () {
                                validateImageAndUpload();
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  changeCategory(String selectedValue) {
    setState(() {
      _currentCategory = selectedValue;
    });
  }

  changeChildCategory(String selectedValue) {
    setState(() {
      _currentChildCategory = selectedValue;
    });
  }

  changeBrand(String selectedBrandValue) {
    setState(() {
      _currentBrand = selectedBrandValue;
    });
  }

  void _uploadImage(Future<PickedFile> pickedImageFile, int imgNo) async {
    String tempPath = await pickedImageFile.then((value) => value.path);
    switch (imgNo) {
      case 1:
        setState(() {
          _img1 = File(tempPath);
        });
        break;
      case 2:
        setState(() {
          _img2 = File(tempPath);
        });
        break;
      case 3:
        setState(() {
          _img3 = File(tempPath);
        });
        break;
    }
  }

  Widget _displayIndividualImage1() {
    if (_img1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 35.0),
        child: Icon(Icons.add, color: Colors.grey),
      );
    } else {
      return Image.file(
        _img1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayIndividualImage2() {
    if (_img2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 35.0),
        child: Icon(Icons.add, color: Colors.grey),
      );
    } else {
      return Image.file(
        _img2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayIndividualImage3() {
    if (_img3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 35.0),
        child: Icon(Icons.add, color: Colors.grey),
      );
    } else {
      return Image.file(
        _img3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateImageAndUpload() async {
    final List imagePaths = [];
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_img1 != null && _img2 != null && _img3 != null) {
        imagePaths.add(_img1);
        imagePaths.add(_img2);
        imagePaths.add(_img3);
        List<String> _categories = [];
        _categories.add(_currentCategory);
        _categories.add(_currentChildCategory);
        try {
          await Provider.of<Products>(context, listen: false)
              .uploadImageAndGetUrls(imagePaths);
          final List<dynamic> urls =
              Provider.of<Products>(context, listen: false).url;

          await Provider.of<Products>(context, listen: false).uploadProduct(
            title: _titleEditingController.text,
            desc: _descEditingController.text,
            categories: _categories,
            brand: _currentBrand,
            pics: urls,
            price: double.parse(_priceEditingController.text),
          );
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(msg: 'Product Added');
          Navigator.of(context).pop();
        } catch (error) {
          print(error);
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An Error Occured !'),
              content: Text('Something went Wrong!'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Plaese upload all the images');
      }
    }
  }
}
