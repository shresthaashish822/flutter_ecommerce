import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/utils/scroll_configuration.dart';
import 'package:flutter/material.dart';

import '/constant/color_properties.dart';
import '/constant/constants.dart';
import '/screens/complete_profile/complete_profile_screen.dart';
import '/utils/size_config.dart';
import '/utils/validation_mixin.dart';
import '/widgets/default_button.dart';
import '/widgets/socal_card.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);
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
                    SizedBox(height: SizeConfig.heightMultiplier * 8), // 4%
                    Text(
                      "Register Account",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: primaryColor,
                          ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "Complete your details or continue \nwith social media",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: colorGrey,
                          ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    const SignUpForm(),
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialCard(
                          icon: "assets/icons/google-icon.svg",
                          press: () {},
                        ),
                        SocialCard(
                          icon: "assets/icons/facebook-2.svg",
                          press: () {},
                        ),
                        SocialCard(
                          icon: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                    Text(
                      'By continuing your confirm that you agree \nwith our Term and Condition',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                    haveAnAccount(context),
                    SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget haveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(
            fontSize: SizeConfig.heightMultiplier * 2.4,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.4,
              decoration: TextDecoration.underline,
              decorationThickness: SizeConfig.heightMultiplier * .4,
              color: secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool remember = false;
  final List<String?> errors = [];
  bool isPasswordObsecure = true;
  bool isConfirmPasswordObsecure = true;

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
            height: SizeConfig.heightMultiplier * 4,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 4,
          ),
          buildConfirmPassFormField(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 4,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: isConfirmPasswordObsecure,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) => ValidationMixin().validatePassword(value!),
      decoration: InputDecoration(
        isDense: true,
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isConfirmPasswordObsecure = !isConfirmPasswordObsecure;
            });
          },
          icon: Icon(
            isConfirmPasswordObsecure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isPasswordObsecure,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
              isPasswordObsecure = !isPasswordObsecure;
            });
          },
          icon: Icon(
            isPasswordObsecure
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
            )),
      ),
    );
  }
}
