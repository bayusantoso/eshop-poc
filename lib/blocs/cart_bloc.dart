import 'package:rxdart/rxdart.dart';
import 'package:lotte_ecommerce/resources/cart_provider.dart';
import 'package:lotte_ecommerce/models/cart/cart.dart';
import 'package:lotte_ecommerce/filters/cart_filter.dart';

class CartBloc {
  final _cartListFetcher = PublishSubject<CartList?>();

  Stream<CartList?> get cartListObj => _cartListFetcher.stream;

  getCartLists(CartFilter? filter) async {
    CartList? responseModel = await CartProvider.getCartLists(filter);
    if (!_cartListFetcher.isClosed) {
      _cartListFetcher.sink.add(responseModel);
    }
    return responseModel;
  }
}
