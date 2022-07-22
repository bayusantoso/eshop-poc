import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:oktoast/oktoast.dart';

class ProductDetail extends StatefulWidget {
  final Product productData;
  const ProductDetail({required this.productData});

  @override
  _ProductDetailState createState() =>
      _ProductDetailState(productData: productData);
}

class _ProductDetailState extends State<ProductDetail> {
  final Product productData;
  _ProductDetailState({required this.productData});

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
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: Hero(
                    tag: productData.id,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: productData.image.toString(),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: const Alignment(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            productData.name.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'Rp ${productData.price}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              alignment: const Alignment(-1.0, -1.0),
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          Container(
                              alignment: const Alignment(-1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  productData.description.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
              onPressed: () {
                showToastWidget(const Text('hello oktoast'));
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                primary: Colors.white,
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ]));
  }
}
