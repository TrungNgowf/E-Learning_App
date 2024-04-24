import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/storage_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
          PageView(
            controller: pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              _welcomePage(
                  "Future of Education",
                  "Online learning has become increasingly popular in recent years, with many institutions offering a variety of online courses and programs.",
                  Assets.imagesWelcome1,
                  false),
              _welcomePage(
                  "Connect the World",
                  "E-learning has been designed to bridge the gap not only between learners and knowledge but also between learners across the globe.",
                  Assets.imagesWelcome2,
                  false),
              _welcomePage(
                  "Anytime, Anywhere",
                  "Access educational resources anytime, anywhere. Whether you're on a coffee break, commuting, or simply relaxing at home.",
                  Assets.imagesWelcome3,
                  true),
            ],
          ),
          Positioned(
            bottom: 10.shp,
            child: SmoothPageIndicator(
              count: 3,
              effect: const WormEffect(
                activeDotColor: AppColors.mainBlue,
                dotHeight: 13,
                dotWidth: 13,
                spacing: 20,
                type: WormType.normal,
              ),
              controller: pageController,
            ),
          ),
        ]),
      ),
    );
  }

  Container _welcomePage(
      String title, String content, String imagePath, bool isLastPage) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5.swp),
      width: 100.swp,
      height: 100.shp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(15.shp),
          Image.asset(
            imagePath,
            height: 40.shp,
          ),
          Gap(5.shp),
          ReusableText(title,
              style:
                  appStyle(color: Colors.black, size: 22, fw: FontWeight.w600)),
          Gap(1.shp),
          ReusableText(content,
              textAlign: TextAlign.left,
              maxLines: 5,
              style:
                  appStyle(color: Colors.black, size: 13, fw: FontWeight.w300)),
          Gap(3.shp),
          CustomButton(
            text: isLastPage == true ? "Get Started" : "Next",
            width: 40.swp,
            height: 5.shp,
            fontSize: 14,
            backGroundColor: AppColors.mainBlue,
            textColor: Colors.white,
            onTap: () {
              if (isLastPage == true) {
                Get.offAllNamed(Routes.LOGIN);
                Global.storageService
                    .setBool(AppStorageService.HAVE_OPENED_BEFORE, true);
              } else {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
          )
        ],
      ),
    );
  }
}
