import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/models/cart/cart.dart';
import 'package:lotte_ecommerce/ui/components/product_shimmer.dart';

class CartPage extends StatefulWidget {
  final Product productData;
  const CartPage({required this.productData});

  @override
  _CartPageState createState() => _CartPageState(productData: productData);
}

class _CartPageState extends State<CartPage> {
  final Product productData;
  _CartPageState({required this.productData});

  Widget buildList(AsyncSnapshot<Cart?> snapshot) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
            itemCount: snapshot.data?.cartItems.length,
            itemBuilder: (context, position) {
              CartItem item = snapshot.data!.cartItems[position];
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: 140.0,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 160,
                              child: Hero(
                                tag: '${item.id}',
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: item.image.toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                item.name.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text('\Rp ${item.price}',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }

  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    //await _storeBloc.getStoreLists(null);
    completer.complete();
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            productData.name.toString(),
            style: const TextStyle(color: Colors.white),
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xFFED1C24),
          centerTitle: true,
        ),
        body: Text("Cart"),
        bottomNavigationBar: Stack(children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(color: Colors.red),
            ),
          ),
          SizedBox(
            width: width,
            height: 50,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                primary: Colors.white,
              ),
              child: const Text('Checkout'),
            ),
          ),
        ]));
  }
}
