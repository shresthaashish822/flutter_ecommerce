import 'package:ecommerce/api/sign_in_api.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/general_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constant/color_properties.dart';
import '/constant/constants.dart';
import '/screens/forgot_password/forgot_password_screen.dart';
import '/screens/login_success/login_success_screen.dart';
import '/utils/scroll_configuration.dart';
import '/utils/size_config.dart';
import '/utils/validation_mixin.dart';
import '/widgets/default_button.dart';
import '/widgets/no_account_text.dart';
import '/widgets/socal_card.dart';
import '../../utils/keyboard.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.heightMultiplier * 2.5,
            ),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    Text(
                      "Welcome Back",
                      style: Theme.of(context).textTheme.headline4!.copyWith(),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "Sign in with your email and password  \nor continue with social media",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: colorGrey,
                          ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    const SignForm(),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SocialCard(
                          icon: "assets/icons/google-icon.svg",
                          press: () {},
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        SocialCard(
                          icon: "assets/icons/facebook-2.svg",
                          press: () {},
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        SocialCard(
                          icon: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    const NoAccountText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
  bool isObsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      email = "binit@gmail.com";
      password = "123456789";
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 3,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 3,
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: secondaryColor,
                fillColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return secondaryColor;
                  }
                  return Theme.of(context).textTheme.headline6!.color!;
                }),
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    decorationThickness: SizeConfig.heightMultiplier * .4,
                    color: secondaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 2.5,
          ),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  GeneralAlertDialog().showLoadingDialog(context);
                  await SignInApi().signInUser(context, email!, password!);
                  await Provider.of<ProductProvider>(context, listen: false)
                      .fetchProduct();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, LoginSuccessScreen.routeName);
                } catch (ex) {
                  Navigator.pop(context);
                  GeneralAlertDialog().showAlertDialog(ex.toString(), context);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isObsecure,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => password = newValue,
      initialValue: password,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) => ValidationMixin().validatePassword(value!),
      decoration: InputDecoration(
        isDense: true,
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObsecure = !isObsecure;
            });
          },
          icon: Icon(
            isObsecure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => email = newValue,
      initialValue: email,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) => ValidationMixin().validateEmail(value!),
      decoration: InputDecoration(
        isDense: true,
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.email_outlined,
          ),
        ),
      ),
    );
  }
}
