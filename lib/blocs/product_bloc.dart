import 'package:rxdart/rxdart.dart';
import 'package:lotte_ecommerce/resources/product_provider.dart';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/filters/product_filter.dart';

class ProductBloc {
  final _productListFetcher = PublishSubject<ProductList?>();

  Stream<ProductList?> get productListObj => _productListFetcher.stream;

  getProductLists(ProductFilter? filter) async {
    ProductList? responseModel = await ProductProvider.getProductLists(filter);
    if (!_productListFetcher.isClosed) {
      _productListFetcher.sink.add(responseModel);
    }
    return responseModel;
  }
}
