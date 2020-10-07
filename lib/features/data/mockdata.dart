import 'package:ktlabs/models/product.dart';

class MockRepository {
  List<Product> mockProductItems = [
    Product(
      id: 'p1',
      title: 'Samsung Note 10',
      description: 'This is awesome phone',
      price: 50000,
      productPic: [
        'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/32020-10-05T23%3A49%3A37.478341.jpg?alt=media&token=8df9ed5d-9392-4db2-827f-c91d75a28e5f',
        'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/22020-10-05T23%3A49%3A37.476535.jpg?alt=media&token=cf11c925-7ac4-4416-8650-518a6f51d5ac',
      ],
      category: ['electronics', 'mobiles'],
      brand: 'Samsung',
    ),
  ];
}
