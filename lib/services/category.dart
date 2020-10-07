import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ktlabs/models/categories.dart';
import 'package:slugify2/slugify.dart';

class CategoryService with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _collectionName = "categories";
  List<CategoryModel> _parentCategories = [];
  List<CategoryModel> _childCategories = [];
  List<String> _allCategories = [];

  List<CategoryModel> get parentCategory {
    return [..._parentCategories];
  }

  List<CategoryModel> get childCategory {
    return [..._childCategories];
  }

  List<String> get allCategories {
    return [..._allCategories];
  }

  void createMasterCategory(String masterCategory) {
    List _ancestorCategory = [];
    final slug = Slugify().slugify(masterCategory);
    _firestore.collection(_collectionName).doc().set(
      {
        "name": masterCategory,
        "slug": slug,
        "ancestorNodes": _ancestorCategory,
        "createdAt": DateTime.now().toIso8601String(),
      },
    );
  }

  void createSubCategory(
    String categoryName,
    String parentCategory,
  ) {
    List _combinedCategories = [parentCategory];
    final slug = Slugify().slugify(categoryName);
    _firestore.collection(_collectionName).doc().set(
      {
        "name": categoryName,
        "slug": slug,
        "ancestorNodes": _combinedCategories,
        "createdAt": DateTime.now().toIso8601String(),
      },
    );
  }

  void createSubSubCategory(
    String subSubCategoryName,
    String parentCategory,
    String subCategory,
  ) {
    List _combinedCategories = [
      parentCategory,
      subCategory,
      subSubCategoryName,
    ];
    final slug = Slugify().slugify(subSubCategoryName);
    _firestore.collection(_collectionName).doc().set(
      {
        "name": subSubCategoryName,
        "slug": slug,
        "ancestorNodes": _combinedCategories,
        "createdAt": DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> fetchAllCategoriesName() {
    _firestore.collection(_collectionName).get().then(
      (value) {
        final response = value.docs;
        List<String> loadAllCategories = [];
        for (var i = 0; i < response.length; i++) {
          final data = response[i];
          loadAllCategories.add(data.data()['name']);
        }
        _allCategories = loadAllCategories;
        notifyListeners();
      },
    );
  }

  Future<void> getCategories() {
    _firestore.collection(_collectionName).get().then((value) {
      final response = value.docs;
      final List<CategoryModel> loadParentCategory = [];
      final List<CategoryModel> loadChildCategory = [];
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        final length = data.data()['ancestorNodes'].length;
        if (length == 0) {
          loadParentCategory.add(
            CategoryModel(
              id: data.id,
              name: data.data()['name'],
              slug: data.data()['slug'],
            ),
          );
        } else {
          loadChildCategory.add(
            CategoryModel(
              id: data.id,
              name: data.data()['name'],
              slug: data.data()['slug'],
            ),
          );
        }
      }
      _parentCategories = loadParentCategory;
      _childCategories = loadChildCategory;
      notifyListeners();
    }).catchError((error) {
      throw (error);
    });
  }
}
