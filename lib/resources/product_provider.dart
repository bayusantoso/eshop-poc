import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/filters/product_filter.dart';
import 'package:lotte_ecommerce/models/store/store.dart';
import 'package:lotte_ecommerce/utils/app_shared_pref.dart';
import 'package:lotte_ecommerce/utils/strings.dart';

class ProductProvider {
  static Future<StoreList?> getProductLists(ProductFilter? filter) async {
    try {
      String query = "";
      if (filter != null) {
        query = filter.name.toString();
      }

      String url = "${Strings.baseApiUrl}product?q=$query";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          StoreList responseObj = StoreList.fromJson(responseJson);
          return responseObj;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (ex) {
      rethrow;
    }
  }
}
