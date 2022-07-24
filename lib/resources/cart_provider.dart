import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotte_ecommerce/models/cart/cart.dart';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/utils/app_shared_pref.dart';
import 'package:lotte_ecommerce/utils/strings.dart';

class CartProvider {
  static Future<Cart?> getCartLists() async {
    try {
    
      String url =
          "${Strings.baseApiUrl}cart";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          Cart responseObj = Cart(responseJson);
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

  static Future<bool> addToCart(Product data) async {
    try {
      String productId = "";
      String storeId = "";
      
      productId = data.id.toString();
      storeId = data.storeId.toString();
      
      String url =
          "${Strings.baseApiUrl}cart/add/$productId/$storeId";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> addQty(CartItem data) async {
    try {
      String productId = "";
      productId = data.productId.toString();
      
      String url =
          "${Strings.baseApiUrl}cart/addqty/$productId";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> subQty(CartItem data) async {
    try {
      String productId = "";
      productId = data.productId.toString();
      
      String url =
          "${Strings.baseApiUrl}cart/subqty/$productId";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson != null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> checkout() async {
    try {
      String url =
          "${Strings.baseApiUrl}cart/checkout";

      AppSharedPref sharedPref = AppSharedPref();
      String token = await sharedPref.getToken();

      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }
}
