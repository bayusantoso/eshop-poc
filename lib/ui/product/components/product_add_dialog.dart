import 'package:flutter/material.dart';
import 'package:lotte_ecommerce/ui/cart/cart.dart';
import 'package:lotte_ecommerce/utils/app_properties.dart';

class ProductAddDialog extends StatelessWidget {
  const ProductAddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget goToCart = InkWell(
      onTap: () async {
        Navigator.of(context).pop();
        Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
      },
      child: Container(
        height: 30,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: const Center(
          child: Text("Go to Cart",
              style: TextStyle(
                  color: Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text:const TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.black87),
                    children: [
                       TextSpan(
                        text: 'Produk berhasil ditambahkan',
                      ),
                    ]),
              ),
            ),
            goToCart
          ])),
    );
  }
}
