import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lotte_ecommerce/blocs/store_bloc.dart';
import 'package:lotte_ecommerce/filters/store_filter.dart';
import 'package:lotte_ecommerce/models/product/product.dart';
import 'package:lotte_ecommerce/models/store/store.dart';
import 'package:lotte_ecommerce/ui/cart/cart.dart';
import 'package:lotte_ecommerce/ui/components/product_shimmer_home.dart';
import 'package:lotte_ecommerce/ui/product/components/promotion.dart';
import 'package:lotte_ecommerce/ui/product/components/section_title.dart';
import 'package:lotte_ecommerce/ui/product/product_detail.dart';
import 'package:lotte_ecommerce/ui/product/product_query_result.dart';
import 'package:lotte_ecommerce/ui/product/product_search_result.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:lotte_ecommerce/utils/size_config.dart';

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
  List<Product> productList = [];
  StoreBloc _storeBloc = StoreBloc();
  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();

    imgList.add(Categories(1, "Produk Segar", "assets/produk_segar.jpg"));
    imgList.add(Categories(2, "Bahan Makanan", "assets/bahan_makanan.jpg"));
    imgList.add(
        Categories(3, "Olahan Susu dan Telur", "assets/susu_dan_olahan.jpg"));
    imgList.add(Categories(4, "Makanan Ringan", "assets/makanan_ringan.jpg"));
    imgList.add(Categories(5, "Rumah Tangga", "assets/rumah_tangga.jpg"));

    StoreFilter filter = StoreFilter();
    _storeBloc.getStoreLists(filter);
  }

  Widget buildMenuItem(
      String item, Widget logoMenu, Color color, dynamic destinationPage) {
    return Column(children: <Widget>[
      Container(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  0.0,
                  0.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
            ],
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(3),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            onPressed: () {
              if (destinationPage != null) {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => destinationPage));
              }
            },
            child: logoMenu,
          )),
      const SizedBox(height: 5.0),
      Text(
        item,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black38, fontSize: 12),
      )
    ]);
  }

  Widget buildList(AsyncSnapshot<StoreList?> snapshot) {
    Store? data = snapshot.data?.results[0];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 240.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0),
        children: data!.products.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 140.0,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                    productData: item,
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 140,
                          child: Hero(
                            tag: 'product_search_result_${item.id}',
                            child: CachedNetworkImage(
                              fit: BoxFit.fitWidth,
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
                          subtitle: Text('\Rp ${oCcy.format(item.price)}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
    );
  }

  final TextEditingController _txtController = TextEditingController();
  bool _isTextExists = false;
  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          centerTitle: false,
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
                    //hintStyle: const TextStyle(
                    //    color: Color.fromARGB(255, 153, 85, 85)),
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
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductQueryResult(
                                  query: '',
                                )));
                  },
                  onSubmitted: (String value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductQueryResult(
                                  query: value,
                                )));
                  },
                ),
              )),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFED1C24),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
            )
          ],
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFED1C24),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xFFDADADA).withOpacity(0.15),
                ),
              ],
            ),
            child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ))),
        body: SafeArea(
            top: false,
            left: false,
            right: false,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  const Promotions(),
                  SizedBox(height: getProportionateScreenWidth(context, 15)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(context, 20)),
                    child: SectionTitle(
                      title: "Categories",
                      press: () {},
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(context, 10)),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    height: 290.0,
                    child: GridView.count(
                      padding: const EdgeInsets.only(top: 12),
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      children: imgList.map((item) {
                        return buildMenuItem(
                            item.label.toString(),
                            Image.asset(
                              item.url.toString(),
                              scale: 2.4,
                            ),
                            const Color.fromARGB(255, 255, 255, 255),
                            ProductSearchResult(categoryId: item.id));
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(context, 15)),
                    child: SectionTitle(
                      title: "Top Products",
                      press: () {},
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(context, 10)),
                  StreamBuilder(
                      stream: _storeBloc.storeListObj,
                      builder: (context, AsyncSnapshot<StoreList?> snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const ProductShimmerHome();
                      })
                ]))));
  }

  @override
  void dispose() {
    super.dispose();
    _txtController.dispose();
  }
}
