
import 'package:lotte_ecommerce/utils/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/models/product/product.dart';

class CartItemList extends StatefulWidget {
  final Product product;
  final VoidCallback onRemove;

  CartItemList(this.product, {required this.onRemove});

  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const  BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.product.name.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: darkGrey,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.only(
                                    left: 32.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Theme(
                          data: ThemeData(
                              accentColor: Colors.black,
                              textTheme: TextTheme(
                                headline6: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                bodyText1: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )),
                          child: const SizedBox()
                          /*NumberPicker(
                            value: quantity,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            },
                          )*/)
                    ])),
          ),
          const Positioned(
              top: 5,
              child: SizedBox()/*ShopProductDisplay(
                widget.product,
                onPressed: widget.onRemove,
              )*/),
        ],
      ),
    );
  }
}
