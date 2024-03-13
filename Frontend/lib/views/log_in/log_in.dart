import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../common/export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 35.shp,
                width: 100.swp,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColors.mainBlue,
                      Colors.green.shade300,
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.swp, vertical: 3.shp),
                  child: SafeArea(
                    child: ReusableText("Welcome\nback!",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: appStyle(
                            size: 40,
                            color: Colors.white,
                            fw: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 75.shp,
                width: 100.swp,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding:
                    EdgeInsets.symmetric(vertical: 2.shp, horizontal: 5.swp),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(2.shp),
                      ReusableText(
                        "Log In",
                        style: appStyle(
                            size: 25, color: Colors.black, fw: FontWeight.w600),
                      ),
                      Gap(5.shp),
                      FormBuilderTextField(
                          name: "email",
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: appStyle(
                                  size: 14,
                                  color: Colors.black,
                                  fw: FontWeight.w300),
                              floatingLabelStyle: appStyle(
                                  size: 14,
                                  color: AppColors.mainBlue,
                                  fw: FontWeight.w300),
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueGrey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColors.mainBlue),
                              ),
                              prefixIcon: const Icon(Icons.email_outlined),
                              prefixIconColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      states.contains(MaterialState.focused)
                                          ? AppColors.mainBlue
                                          : Colors.black)),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ])),
                      Gap(2.shp),
                      FormBuilderTextField(
                          name: "password",
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: appStyle(
                                  size: 14,
                                  color: Colors.black,
                                  fw: FontWeight.w300),
                              floatingLabelStyle: appStyle(
                                  size: 14,
                                  color: AppColors.mainBlue,
                                  fw: FontWeight.w300),
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueGrey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColors.mainBlue),
                              ),
                              prefixIcon: const Icon(Icons.email_outlined),
                              prefixIconColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      states.contains(MaterialState.focused)
                                          ? AppColors.mainBlue
                                          : Colors.black)),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])),
                      Gap(1.shp),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgot_password");
                          },
                          child: ReusableText(
                            "Forgot password?",
                            style: appStyle(
                                size: 14,
                                color: AppColors.mainBlue,
                                fw: FontWeight.w300),
                          ),
                        ),
                      ),
                      Gap(3.shp),
                      Container(
                        width: 90.swp,
                        height: 6.shp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainBlue,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.mainBlue.withOpacity(0.5),
                          //     spreadRadius: 1,
                          //     blurRadius: 5,
                          //     offset: const Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Center(
                          child: ReusableText(
                            "Log in",
                            style: appStyle(
                                size: 16,
                                color: Colors.white,
                                fw: FontWeight.w600),
                          ),
                        ),
                      ),
                      Gap(2.shp),
                      Container(
                        width: 90.swp,
                        height: 6.shp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.mainBlue),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.mainBlue.withOpacity(0.5),
                          //     spreadRadius: 1,
                          //     blurRadius: 5,
                          //     offset: const Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Center(
                          child: ReusableText(
                            "Sign up",
                            style: appStyle(
                                size: 16,
                                color: AppColors.mainBlue,
                                fw: FontWeight.w600),
                          ),
                        ),
                      ),
                      Gap(4.shp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: Divider()),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.swp),
                            child: ReusableText("Or log in with",
                                style: appStyle(
                                    size: 14,
                                    color: Colors.black,
                                    fw: FontWeight.w300)),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      Gap(4.shp),
                      thirdPartyLogin()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thirdPartyLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          Assets.iconsGoogle,
          width: 13.swp,
        ),
        Image.asset(
          Assets.iconsFacebook,
          width: 13.swp,
        ),
        Image.asset(
          Assets.iconsApple,
          width: 13.swp,
        ),
      ],
    );
  }
}
