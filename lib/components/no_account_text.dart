import 'package:ecommerce/constant/color_properties.dart';
import 'package:flutter/material.dart';

import '/screens/sign_up/sign_up_screen.dart';
import '/utils/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(
            fontSize: SizeConfig.heightMultiplier * 2.4,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.4,
              decoration: TextDecoration.underline,
              decorationColor: secondaryColor,
              decorationThickness: SizeConfig.heightMultiplier * .4,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
