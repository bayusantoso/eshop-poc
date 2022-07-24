import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lotte_ecommerce/resources/cart_provider.dart';
import 'package:lotte_ecommerce/models/cart/cart.dart';

class CartBloc {
  final _cartListFetcher = PublishSubject<Cart?>();

  Stream<Cart?> get cartObj => _cartListFetcher.stream;

  getCartLists() async {
    Cart? responseModel = await CartProvider.getCartLists();
    if (!_cartListFetcher.isClosed) {
      _cartListFetcher.sink.add(responseModel);
    }
    return responseModel;
  }

  Future<bool> addToCart(Product data) async {
    return CartProvider.addToCart(data);
  }

  Future<bool> addQty(CartItem data) async {
    return CartProvider.addQty(data);
  }

  Future<bool> subQty(CartItem data) async {
    return CartProvider.subQty(data);
  }

  Future<bool> checkout() async {
    return CartProvider.checkout();
  }
}
