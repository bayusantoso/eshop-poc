import 'package:lotte_ecommerce/models/product/product.dart';

class CartList {
  int _page = 0;
  int _totalResults = 0;
  int _totalPages = 0;
  List<Cart> _results = [];

  CartList.fromJson(List<dynamic> parsedJson) {
    List<dynamic> dataJson = parsedJson;
    List<Cart> temp = [];

    _totalResults = dataJson.length;
    for (int i = 0; i < dataJson.length; i++) {
      Cart result = Cart(dataJson[i]);
      temp.add(result);
    }
    _results = temp;
  }

  int get totalResults => _totalResults;
  List<Cart> get results => _results;
}

class Cart {
  int _id = 0;
  double? _total = 0;
  List<CartItem> _cartItems = [];

  int get id => _id;
  double? get total => _total;
  List<CartItem> get cartItems => _cartItems;

  Cart(Map<String, dynamic> dataJson) {
    _id = dataJson["id"];
    _total = dataJson["double"];

    List<CartItem> cartItems = [];
    if (dataJson["cartItems"] != null) {
      if (dataJson["cartItems"].length > 0) {
        dataJson["cartItems"].forEach((item) {
          CartItem cartItem = CartItem(item);
          cartItems.add(cartItem);
        });
      }
    }
    _cartItems = cartItems;
  }
}

class CartItem {
  int _id = 0;
  String? _name;
  int? _price;
  String? _image;
  String? _description;
  int? _storeId;

  int _productId = 0;
  String productName = "";
  double productPrice = 0;
  int productQty = 1;
  double productSubtotal = 0;

  int get id => _id;
  String? get name => _name;
  int? get price => _price;
  String? get image => _image;
  String? get description => _description;
  int? get storeId => _storeId;

  CartItem(Map<String, dynamic> dataJson) {
    _id = dataJson["id"];
    _name = dataJson["name"];
    _price = dataJson["price"];
    _image = dataJson["image"];
    _description = dataJson["description"];
    _storeId = dataJson["storeId"];
  }
}
