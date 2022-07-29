import 'package:flutter/material.dart';

import 'package:lotte_ecommerce/utils/size_config.dart';
import 'section_title.dart';

class Promotions extends StatelessWidget {
  const Promotions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(context, 20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),*/
        SizedBox(height: getProportionateScreenWidth(context, 20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/lotte_header/1.jpeg",
                category: "Smartphone",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/lotte_header/2.jpeg",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/lotte_header/3.jpeg",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(context, 20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(context, 20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(context, 270),
          height: getProportionateScreenWidth(context, 130),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 325,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
