import 'package:rxdart/rxdart.dart';
import 'package:lotte_ecommerce/resources/store_provider.dart';
import 'package:lotte_ecommerce/models/store/store.dart';
import 'package:lotte_ecommerce/filters/store_filter.dart';

class StoreBloc {
  final _storeListFetcher = PublishSubject<StoreList?>();

  Stream<StoreList?> get storeListObj => _storeListFetcher.stream;

  getStoreLists(StoreFilter? filter) async {
    StoreList? responseModel = await StoreProvider.getStoreLists(filter);
    if (!_storeListFetcher.isClosed) {
      _storeListFetcher.sink.add(responseModel);
    }
    return responseModel;
  }
}
