import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String parentId;
  CategoryModel({
    @required this.id,
    @required this.name,
    @required this.slug,
    this.parentId,
  });
}
