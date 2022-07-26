import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/blocs/cart_bloc.dart';
import 'package:lotte_ecommerce/models/cart/cart.dart';
import 'package:lotte_ecommerce/ui/cart/components/cart_checkout_dialog.dart';
import 'package:lotte_ecommerce/ui/components/product_shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _onProgress = false;
  bool _isCartExists = false;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  List<CartItem> cartItems = [];

  final CartBloc _cartBloc = CartBloc();
  @override
  void initState() {
    super.initState();
    _cartBloc.getCartLists();
  }

  Widget buildColor(AsyncSnapshot<Cart?> snapshot) {
    if (snapshot.data!.cartItems.isNotEmpty) {
      return Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
        ),
      );
    }
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 175, 175, 175),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Cart?> snapshot) {
    if (snapshot.data!.cartItems.isNotEmpty) {
      _isCartExists = true;
    }
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
                            ListTile(
                                leading: SizedBox(
                                  width: 100,
                                  child: Hero(
                                    tag: 'cart_${item.productId}',
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: item.productImage.toString(),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.productName.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                subtitle: Column(
                                  children: [
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '\Rp ${oCcy.format(item.productPrice)}',
                                            style: const TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w200)),
                                        Text(
                                            '\Rp ${oCcy.format(item.productSubtotal)}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _cartBloc
                                                        .subQty(item)
                                                        .then((value) {
                                                      _cartBloc.getCartLists();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                  )),
                                              Text(item.productQty.toString()),
                                              IconButton(
                                                  onPressed: () {
                                                    _cartBloc
                                                        .addQty(item)
                                                        .then((value) {
                                                      _cartBloc.getCartLists();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                  )),
                                            ],
                                          ),
                                        ))
                                  ],
                                ))
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
          title: const Center(
              child: Text(
            "Checkout",
            style: TextStyle(color: Colors.white),
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xFFED1C24),
          centerTitle: true,
          actions: const [SizedBox(width: 100)],
        ),
        body: StreamBuilder(
            stream: _cartBloc.cartObj,
            builder: (context, AsyncSnapshot<Cart?> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const ProductShimmer();
            }),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: _cartBloc.cartObj,
                builder: (context, AsyncSnapshot<Cart?> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Total : ${oCcy.format(snapshot.data?.total)}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ));
                  } else if (snapshot.hasError) {
                    return const Text("");
                  }
                  return const CircularProgressIndicator();
                }),
            Stack(children: [
              StreamBuilder(
                  stream: _cartBloc.cartObj,
                  builder: (context, AsyncSnapshot<Cart?> snapshot) {
                    if (snapshot.hasData) {
                      return buildColor(snapshot);
                    } else if (snapshot.hasError) {
                      return Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 175, 175, 175),
                          ),
                        ),
                      );
                    }
                    return Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 175, 175, 175),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                width: width * 0.5,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    if (!_isCartExists) return;
                    if (_onProgress) return;

                    setState(() {
                      _onProgress = true;
                    });
                    _cartBloc.checkout().then((value) {
                      if (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Dialog(
                              shape: BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: CartCheckOutDialog(),
                            );
                          },
                        );
                      }
                      setState(() {
                        _onProgress = false;
                      });
                    }).onError((error, stackTrace) {
                      setState(() {
                        _onProgress = false;
                      });
                    });
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    primary: Colors.white,
                  ),
                  child: !_onProgress
                      ? const Text('Checkout')
                      : const CircularProgressIndicator(),
                ),
              ),
            ])
          ],
        ));
  }
}
