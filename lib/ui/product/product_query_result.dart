import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/filters/product_filter.dart';
import 'package:lotte_ecommerce/models/store/store.dart';
import 'package:lotte_ecommerce/ui/cart/cart.dart';
import 'package:lotte_ecommerce/ui/components/product_shimmer.dart';
import 'package:lotte_ecommerce/blocs/product_bloc.dart';
import 'package:lotte_ecommerce/ui/product/product_detail.dart';

class ProductQueryResult extends StatefulWidget {
  final String query;
  const ProductQueryResult({required this.query});

  @override
  _ProductQueryResultState createState() =>
      _ProductQueryResultState(query: query);
}

class _ProductQueryResultState extends State<ProductQueryResult> {
  final String query;
  _ProductQueryResultState({required this.query});
  final ProductBloc _productBloc = ProductBloc();
  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    ProductFilter filter = ProductFilter();
    filter.name = query;
    //_productBloc.getProductLists(filter);

    _txtController.text = query;

    if (query.isNotEmpty) _isTextExists = true;
  }

  Widget buildList(AsyncSnapshot<StoreList?> snapshot) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: snapshot.data?.results.length,
          itemBuilder: (context, position) {
            Store? data = snapshot.data?.results[position];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                    child: Text(data!.name.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 240.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: data.products.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: 140.0,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                                  productData: item,
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 160,
                                        child: Hero(
                                          tag:
                                              'product_query_result_${data.id}_${item.id}',
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fitWidth,
                                            imageUrl: item.image.toString(),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          item.name.toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        subtitle: Text(
                                            '\Rp ${oCcy.format(item.price)}',
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
                      }).toList(),
                    ),
                  ),
                ]);

            //GestureDetector(onTap: () {}, child: Text(data!.name.toString()));
          },
        ));
  }

  String newQuery = '';
  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    ProductFilter filter = ProductFilter();
    filter.name = query;
    if (newQuery != null) {
      filter.name = newQuery;
    }
    await _productBloc.getProductLists(filter);
    completer.complete();
    return completer.future;
  }

  final TextEditingController _txtController = TextEditingController();
  bool _isTextExists = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: TextField(
                  controller: _txtController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _isTextExists = true;
                      } else {
                        _isTextExists = false;
                      }
                    });
                  },
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 234, 108, 112),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color(0xFFED1C24),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    //fillColor: const Color.fromARGB(255, 234, 108, 112),
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    focusColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Cari Barang di sini',
                    prefixIcon: IconButton(
                      iconSize: 20.0,
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    suffixIcon: !_isTextExists
                        ? const SizedBox()
                        : IconButton(
                            iconSize: 20.0,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _txtController.clear();

                              setState(() {
                                _isTextExists = false;
                              });
                            },
                          ),
                  ),
                  onSubmitted: (String value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    newQuery = value;
                    _onRefresh();
                  },
                ),
              )),
          /*SizedBox(
            height: 40.0,
            child: TextField(
              controller: _txtController,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _isTextExists = true;
                  } else {
                    _isTextExists = false;
                  }
                });
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: !_isTextExists
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _txtController.clear();

                          setState(() {
                            _isTextExists = false;
                          });
                        }),
              ),
              style: const TextStyle(fontSize: 15.0),
              onSubmitted: (String value) {
                newQuery = value;
                _onRefresh();
              },
            ),
          ),*/
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xFFED1C24),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
            )
          ],
        ),
        body: _isTextExists
            ? StreamBuilder(
                stream: _productBloc.productListObj,
                builder: (context, AsyncSnapshot<StoreList?> snapshot) {
                  if (snapshot.hasData) {
                    return buildList(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const ProductShimmer();
                })
            : Container());
  }
}
