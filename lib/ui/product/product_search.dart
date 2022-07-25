import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/ui/cart/cart.dart';
import 'package:lotte_ecommerce/ui/product/product_query_result.dart';
import 'package:lotte_ecommerce/ui/product/product_search_result.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class Categories {
  int id;
  String? label;
  String? url;

  Categories(this.id, this.label, this.url);
}

class _ProductSearchState extends State<ProductSearch> {
  List<Categories> imgList = [];

  @override
  void initState() {
    super.initState();

    imgList.add(Categories(1, "Produk Segar", "assets/produk_segar.jpg"));
    imgList.add(Categories(2, "Bahan Makanan", "assets/bahan_makanan.jpg"));
    imgList.add(
        Categories(3, "Olahan Susu dan Telur", "assets/susu_dan_olahan.jpg"));
    imgList.add(Categories(4, "Makanan Ringan", "assets/makanan_ringan.jpg"));
    imgList.add(
        Categories(5, "Rumah Tangga dan Hewan", "assets/rumah_tangga.jpg"));
  }

  Widget buildMenuItem(
      String item, Widget logoMenu, Color color, dynamic destinationPage) {
    return Column(children: <Widget>[
      SizedBox(
        width: 80.0,
        height: 80.0,
        child: (FlatButton(
          onPressed: () {
            if (destinationPage != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => destinationPage));
            }
          },
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: logoMenu,
        )),
      ),
      const SizedBox(height: 5.0),
      Text(
        item,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black38, fontSize: 15),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /*title: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            height: 50,
            imageUrl: 'assets/logo.webp',
            placeholder: (context, url) => const Center(child: Text("")),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Image.asset(
            'assets/logo.webp',
            scale: 0.1,
          ),*/
          title: const Text(
            "LOTTE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFED1C24),
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
        body: SafeArea(
            top: false,
            left: false,
            right: false,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                            color: Color(0xFFED1C24),
                          ),
                        ),
                        hintText: 'Search',
                      ),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                    child: Text("Categories",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 500.0,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: imgList.map((item) {
                        return buildMenuItem(
                            item.label.toString(),
                            /*CachedNetworkImage(
                              fit: BoxFit.fitHeight,
                              imageUrl: item.url.toString(),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),*/
                            Image.asset(
                              item.url.toString(),
                              scale: 0.5,
                            ),
                            const Color.fromARGB(255, 255, 255, 255),
                            ProductSearchResult(categoryId: item.id));
                      }).toList(),
                    ),
                  ),
                ]))));
  }
}
