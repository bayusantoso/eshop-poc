import 'package:lotte_ecommerce/models/product/product.dart';

class StoreList {
  int _page = 0;
  int _totalResults = 0;
  int _totalPages = 0;
  List<Store> _results = [];

  StoreList.fromJson(List<dynamic> parsedJson) {
    List<dynamic> dataJson = parsedJson;
    List<Store> temp = [];

    _totalResults = dataJson.length;
    for (int i = 0; i < dataJson.length; i++) {
      Store result = Store(dataJson[i]);
      temp.add(result);
    }
    _results = temp;
  }

  int get totalResults => _totalResults;
  List<Store> get results => _results;
}

class Store {
  int _id = 0;
  String? _name;
  List<Product> _products = [];

  int get id => _id;
  String? get name => _name;
  List<Product> get products => _products;

  Store(Map<String, dynamic> dataJson) {
    _id = dataJson["id"];
    _name = dataJson["storeName"];

    List<Product> products = [];
    if (dataJson["products"] != null) {
      if (dataJson["products"].length > 0) {
        dataJson["products"].forEach((item) {
          Product productObj = Product(item);
          products.add(productObj);
        });
      }
    }
    _products = products;
  }
}
