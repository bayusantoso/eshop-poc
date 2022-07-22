class ProductList {
  int _page = 0;
  int _totalResults = 0;
  int _totalPages = 0;
  List<Product> _results = [];

  ProductList.fromJson(List<dynamic> parsedJson) {
    List<dynamic> dataJson = parsedJson;
    List<Product> temp = [];

    _totalResults = dataJson.length;
    for (int i = 0; i < dataJson.length; i++) {
      Product result = Product(dataJson[i]);
      temp.add(result);
    }
    _results = temp;
  }

  int get totalResults => _totalResults;
  List<Product> get results => _results;
}

class Product {
  int _id = 0;
  String? _name;
  int? _price;
  String? _image;
  String? _description;
  int? _storeId;

  int get id => _id;
  String? get name => _name;
  int? get price => _price;
  String? get image => _image;
  String? get description => _description;
  int? get storeId => _storeId;

  Product(Map<String, dynamic> dataJson) {
    _id = dataJson["id"];
    _name = dataJson["name"];
    _price = dataJson["price"];
    _image = dataJson["image"];
    _description = dataJson["description"];
    _storeId = dataJson["storeId"];
  }
}
