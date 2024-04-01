import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_event.dart';
import 'package:e_learning_app/views/log_in/log_in_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../utils/export.dart';
import 'bloc/log_in_bloc.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();
  bool hidePwd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 35.shp,
              width: 100.swp,
              decoration: const BoxDecoration(
                gradient: AppColors.blueGreenGradient,
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.swp, vertical: 3.shp),
                child: SafeArea(
                  child: ReusableText("Welcome\nback!",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: appStyle(
                          size: 40, color: Colors.white, fw: FontWeight.w600)),
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
              padding: EdgeInsets.symmetric(vertical: 2.shp, horizontal: 5.swp),
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: _loginKey,
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
                      CustomTextField(
                          name: "email",
                          label: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          onChanged: (value) {
                            context
                                .read<LogInBloc>()
                                .add(EmailEvent(email: value.toString()));
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ])),
                      Gap(2.shp),
                      FormBuilderTextField(
                        name: "password",
                        onChanged: (value) {
                          context
                              .read<LogInBloc>()
                              .add(PasswordEvent(password: value.toString()));
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: appStyle(
                                size: 14,
                                color: Colors.black,
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
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidePwd = !hidePwd;
                                });
                              },
                              child: Icon(
                                hidePwd
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            )),
                        obscureText: hidePwd,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
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
                      CustomButton(
                        text: "Log In",
                        backGroundColor: AppColors.mainBlue,
                        textColor: Colors.white,
                        height: 6.shp,
                        width: 90.swp,
                        onTap: () {
                          if (_loginKey.currentState!.saveAndValidate()) {
                            LogInController(context).logIn();
                          }
                        },
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainBlue.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      Gap(2.shp),
                      CustomButton(
                          text: "Sign Up",
                          backGroundColor: Colors.white,
                          textColor: AppColors.mainBlue,
                          height: 6.shp,
                          width: 90.swp,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainBlue.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          border: Border.all(color: AppColors.mainBlue),
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP);
                          }),
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
          ),
        ],
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
