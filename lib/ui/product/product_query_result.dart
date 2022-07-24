import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    ProductFilter filter = ProductFilter();
    filter.name = query;
    _productBloc.getProductLists(filter);

    _txtController.text = query;
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
                                          tag: '${item.id}',
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
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
                      }).toList(),
                    ),
                  ),
                ]);

            //GestureDetector(onTap: () {}, child: Text(data!.name.toString()));
          },
        ));
  }

  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    await _productBloc.getProductLists(null);
    completer.complete();
    return completer.future;
  }

  final TextEditingController _txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 40.0,
            child: TextField(
              controller: _txtController,
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
              ),
              style: const TextStyle(fontSize: 15.0, height: 1.0),
              onSubmitted: (String value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductQueryResult(
                              query: value,
                            )));
              },
            ),
          ),
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
        body: StreamBuilder(
            stream: _productBloc.productListObj,
            builder: (context, AsyncSnapshot<StoreList?> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const ProductShimmer();
            }));
  }
}
