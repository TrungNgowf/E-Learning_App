import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/sign_up/bloc/sign_up_bloc.dart';
import 'package:e_learning_app/views/sign_up/sign_up_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormBuilderState> _signupKey = GlobalKey<FormBuilderState>();
  bool hidePwd = true;
  bool hideRePwd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: ReusableText("Get\nstarted!",
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
              child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: FormBuilder(
                      key: _signupKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(2.shp),
                          ReusableText(
                            "Sign Up",
                            style: appStyle(
                                size: 25,
                                color: Colors.black,
                                fw: FontWeight.w600),
                          ),
                          Gap(5.shp),
                          CustomTextField(
                              name: "username",
                              label: "Username",
                              prefixIcon: const Icon(Icons.person_outline),
                              onChanged: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .add(UsernameEvent(value.toString()));
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ])),
                          Gap(2.shp),
                          CustomTextField(
                              name: "email",
                              label: "Email",
                              prefixIcon: const Icon(Icons.email_outlined),
                              onChanged: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .add(EmailEvent(value.toString()));
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
                                  .read<SignUpBloc>()
                                  .add(PasswordEvent(value.toString()));
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
                                  borderSide: const BorderSide(
                                      color: AppColors.mainBlue),
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
                          Gap(2.shp),
                          FormBuilderTextField(
                            name: "re-password",
                            onChanged: (value) {
                              context
                                  .read<SignUpBloc>()
                                  .add(ConfirmPasswordEvent(value.toString()));
                            },
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
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
                                  borderSide: const BorderSide(
                                      color: AppColors.mainBlue),
                                ),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hideRePwd = !hideRePwd;
                                    });
                                  },
                                  child: Icon(
                                    hideRePwd
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                )),
                            obscureText: hideRePwd,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.equal(
                                  context.read<SignUpBloc>().state.password,
                                  errorText: "Password does not match"),
                            ]),
                          ),
                          Gap(3.shp),
                          CustomButton(
                            text: "Sign Up",
                            backGroundColor: AppColors.mainBlue,
                            textColor: Colors.white,
                            height: 6.shp,
                            width: 90.swp,
                            onTap: () {
                              if (_signupKey.currentState!.saveAndValidate()) {
                                SignUpController(context).signUp();
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Divider()),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.swp),
                                child: ReusableText("Already have an account?",
                                    style: appStyle(
                                        size: 14,
                                        color: Colors.black,
                                        fw: FontWeight.w300)),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          Gap(1.shp),
                          CustomButton(
                              text: "Log In",
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
                                Get.toNamed(Routes.LOGIN);
                              }),
                        ],
                      ),
                    ),
                  );
                },
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
