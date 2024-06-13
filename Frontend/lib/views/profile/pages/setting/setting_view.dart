import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/navigation/bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Setting",
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(3.shp),
            profileRow(FontAwesomeIcons.user, "Personal", onTap: () {}),
            Gap(2.shp),
            profileRow(FontAwesomeIcons.bell, "Notification", onTap: () {}),
            Gap(2.shp),
            profileRow(FontAwesomeIcons.language, "Language", onTap: () {}),
            Gap(2.shp),
            profileRow(FontAwesomeIcons.lock, "Privacy", onTap: () {}),
            Gap(2.shp),
            profileRow(FontAwesomeIcons.circleInfo, "About", onTap: () {}),
            Gap(3.shp),
            CustomButton(
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (context) => logOutDialog(context));
                logout(context);
              },
              backGroundColor: AppColors.mainRed,
              textColor: Colors.white,
              width: 50.swp,
              height: 6.shp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, color: Colors.white),
                  Gap(2.swp),
                  ReusableText("Log Out",
                      style: appStyle(
                          color: Colors.white, size: 16, fw: FontWeight.w600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget logOutDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: ReusableText(
          "Log Out",
          style:
              appStyle(size: 25, fw: FontWeight.bold, color: AppColors.mainRed),
        ),
      ),
      content: ReusableText(
        "Are you sure you want to log out?",
        style: appStyle(size: 20, fw: FontWeight.w500),
      ),
      actions: [
        CustomButton(
            onTap: () => logout(context),
            backGroundColor: AppColors.mainRed,
            textColor: Colors.white,
            height: 5.shp,
            width: 20.swp,
            child: ReusableText("Yes",
                style: appStyle(
                    color: Colors.white, size: 16, fw: FontWeight.w600))),
        CustomButton(
            onTap: () {
              Get.back();
            },
            height: 5.shp,
            width: 20.swp,
            backGroundColor: Colors.white,
            textColor: AppColors.mainRed,
            child: ReusableText("No",
                style: appStyle(
                    color: AppColors.mainRed, size: 16, fw: FontWeight.w600))),
      ],
    );
  }
}

Widget profileRow(IconData icon, String title,
    {required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 90.swp,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlue.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ]),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.mainBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white)),
          Gap(3.swp),
          ReusableText(title,
              style:
                  appStyle(color: Colors.black, size: 16, fw: FontWeight.w600)),
        ],
      ),
    ),
  );
}

void logout(BuildContext context) {
  Global.storageService.logout();
  context.read<NavigationBloc>().add(NavigationPageChanged(page: 0));
  Get.offNamedUntil(Routes.LOGIN, (route) => false);
}
