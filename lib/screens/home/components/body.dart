import 'package:flutter/material.dart';

import '/utils/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            HomeHeader(),
            SizedBox(
              height: SizeConfig.heightMultiplier,
            ),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            PopularProducts(),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
