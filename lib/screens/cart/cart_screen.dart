import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/models/cart.dart';
import 'cart_card.dart';
import 'check_out_card.dart';
import '/constant/color_properties.dart';
import '/utils/size_config.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.5 * SizeConfig.heightMultiplier,
          ),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.heightMultiplier),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colorWhite,
                    foregroundColor: primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Cart',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier,
                      ),
                      Text(
                        '3 Items',
                        style: Theme.of(context).textTheme.caption!.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: demoCarts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(demoCarts[index].product.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          demoCarts.removeAt(index);
                        });
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: CartCard(cart: demoCarts[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CheckoutCard(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
          ),
          Text(
            "${demoCarts.length} items",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
