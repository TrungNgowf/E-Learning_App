import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Profile",
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
        ),
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Gap(3.shp),
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(Assets.imagesPEPE),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.mainBlue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ReusableText(
              Global.storageService.currentUser!.username,
              style:
                  appStyle(size: 20, color: Colors.black, fw: FontWeight.w600),
            ),
            ReusableText(
              Global.storageService.currentUser!.email,
            ),
            Gap(1.shp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  backGroundColor: AppColors.mainBlue,
                  textColor: Colors.white,
                  width: 35.swp,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        ReusableText("My courses",
                            style: appStyle(color: Colors.white, size: 14)),
                      ]),
                ),
                CustomButton(
                  backGroundColor: AppColors.mainBlue,
                  textColor: Colors.white,
                  width: 35.swp,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                        ReusableText("Buy courses",
                            style: appStyle(color: Colors.white, size: 14)),
                      ]),
                ),
              ],
            ),
            Gap(1.shp),
            if (!Global.storageService.isInstructor) instructorBtn(),
            Gap(1.shp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileRow(Icons.settings, "Settings", onTap: () {
                  Get.toNamed(Routes.SETTINGS);
                }),
                Gap(1.shp),
                profileRow(Icons.payment, "Payment details", onTap: () {
                  // Get.toNamed(Routes.PAYMENT);
                }),
                Gap(1.shp),
                profileRow(FontAwesomeIcons.award, "Achievements", onTap: () {
                  // Get.toNamed(Routes.ACHIEVEMENTS);
                }),
                Gap(1.shp),
                profileRow(FontAwesomeIcons.solidHeart, "Liked", onTap: () {
                  // Get.toNamed(Routes.LIKED);
                }),
                Gap(1.shp),
                profileRow(FontAwesomeIcons.clock, "Reminder", onTap: () {
                  // Get.toNamed(Routes.REMINDER);
                }),
                Gap(2.shp),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  GestureDetector instructorBtn() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.INSTRUCTOR_REGISTRATION);
      },
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
        child: Column(
          children: [
            ReusableText("Want to upload a course?",
                style: appStyle(
                    size: 14, fw: FontWeight.w600, color: Colors.black)),
            GradientText(
              "Become an instructor now!",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              colors: const [AppColors.mainBlue, AppColors.mainGreen],
            ),
          ],
        ),
      ),
    );
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
                style: appStyle(
                    color: Colors.black, size: 16, fw: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
