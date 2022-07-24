import 'package:rxdart/rxdart.dart';
import 'package:lotte_ecommerce/resources/product_provider.dart';
import 'package:lotte_ecommerce/models/store/store.dart';
import 'package:lotte_ecommerce/filters/product_filter.dart';

class ProductBloc {
  final _productListFetcher = PublishSubject<StoreList?>();

  Stream<StoreList?> get productListObj => _productListFetcher.stream;

  getProductLists(ProductFilter? filter) async {
    StoreList? responseModel = await ProductProvider.getProductLists(filter);
    if (!_productListFetcher.isClosed) {
      _productListFetcher.sink.add(responseModel);
    }
    return responseModel;
  }
}
