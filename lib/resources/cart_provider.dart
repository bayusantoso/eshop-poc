import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotte_ecommerce/models/cart/cart.dart';
import 'package:lotte_ecommerce/filters/cart_filter.dart';
import 'package:lotte_ecommerce/utils/app_shared_pref.dart';
import 'package:lotte_ecommerce/utils/strings.dart';

class CartProvider {
  static Future<CartList?> getCartLists(CartFilter? filter) async {
    try {
      String query = "";
      String categoryId = "";
      if (filter != null) {
        query = filter.name.toString();
        categoryId = filter.categoryId.toString();
      }

      String url =
          "${Strings.baseApiUrl}product/?q=$query&categoryId=$categoryId";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          CartList responseObj = CartList.fromJson(responseJson);
          return responseObj;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }
}
