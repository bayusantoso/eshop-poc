import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/filters/product_filter.dart';
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

  Widget buildList(AsyncSnapshot<ProductList?> snapshot) {
    List<Product> products = snapshot.data!.results;
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: GridView.count(
            crossAxisCount: 3,
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            childAspectRatio: 0.6,
            children: products.map((data) {
              return Container(
                height: 250.0,
                child: Builder(
                  builder: (BuildContext context) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                        productData: data,
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 140,
                              child: Hero(
                                tag: '${data.id}',
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: data.image.toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                data.name.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text('\Rp ${data.price}',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList()

            //GestureDetector(onTap: () {}, child: Text(data!.name.toString()));
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
            builder: (context, AsyncSnapshot<ProductList?> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const ProductShimmer();
            }));
  }
}
