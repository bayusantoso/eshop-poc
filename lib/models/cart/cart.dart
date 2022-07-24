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
    _total = dataJson["total"];

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
  int _productId = 0;
  String _productName = "";
  double _productPrice = 0;
  int _productQty = 1;
  double _productSubtotal = 0;

  int get productId => _productId;
  String get productName => _productName ;
  double get productPrice => _productPrice;
  int get productQty => _productQty;
  double get productSubtotal  => _productSubtotal;

  CartItem.fromData(this._productId, this._productName, this._productPrice, this._productQty, this._productSubtotal);

  CartItem(Map<String, dynamic> dataJson) {
    _productId = dataJson["productId"];
    _productName = dataJson["productName"];
    _productPrice = dataJson["productPrice"];
    _productQty = dataJson["productQty"];
    _productSubtotal = dataJson["productSubtotal"];
  }
}
