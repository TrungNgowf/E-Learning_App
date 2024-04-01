import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> coursesRecommendation = [
    Assets.imagesRcmCourse1,
    Assets.imagesRcmCourse2,
    Assets.imagesRcmCourse3,
  ];
  int rcmCourseIndex = 0;
  int chosenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: "Home",
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
                Icons.account_circle_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(3.swp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(1.shp),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        "Hello,",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: appStyle(
                          size: 25,
                          color: Colors.black,
                          fw: FontWeight.w600,
                        ),
                      ),
                      GradientText(
                        "John Doe",
                        style: appStyle(
                          size: 30,
                          fw: FontWeight.w600,
                        ),
                        colors: const [AppColors.mainBlue, AppColors.mainGreen],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 6.shp,
                        child: const CustomTextField(
                          name: "course-search",
                          label: "Search for courses",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Gap(2.swp),
                    Container(
                      height: 6.shp,
                      width: 6.shp,
                      decoration: BoxDecoration(
                        color: AppColors.mainBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(2.shp),
                CarouselSlider(
                    items: coursesRecommendation
                        .map((e) => Container(
                            width: 100.swp,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(e, fit: BoxFit.fill)))
                        .toList(),
                    options: CarouselOptions(
                      height: 17.shp,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          rcmCourseIndex = index;
                        });
                      },
                    )),
                Gap(0.5.shp),
                DotsIndicator(
                    dotsCount: coursesRecommendation.length,
                    position: rcmCourseIndex,
                    decorator: const DotsDecorator(
                      color: Colors.grey,
                      activeColor: AppColors.mainBlue,
                    )),
                Gap(2.shp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ReusableText("Choose Your Course",
                        style: appStyle(
                          size: 18,
                          color: Colors.black,
                          fw: FontWeight.w600,
                        )),
                    ReusableText("See All",
                        style: appStyle(
                          size: 14,
                          color: AppColors.mainBlue,
                          fw: FontWeight.w600,
                        )),
                  ],
                ),
                Gap(1.shp),
                btnCourseRow(chosenIndex),
                Gap(1.shp),
                SizedBox(
                  height: 40.shp,
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2.swp,
                        mainAxisSpacing: 2.swp,
                        crossAxisCount: 2,
                        childAspectRatio: 1.6),
                    itemBuilder: (context, index) {
                      return Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Stack(children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 10.shp,
                                width: 46.swp,
                                child: Image.asset(
                                  Assets.imagesCoursePlaceHolder,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(1.swp),
                                  color: Colors.white,
                                  width: 46.swp,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ReusableText("Course Name",
                                          style: appStyle(
                                            size: 10,
                                            color: Colors.black,
                                            fw: FontWeight.w600,
                                          )),
                                      ReusableText("Course Description",
                                          style: appStyle(
                                            size: 9,
                                            color: Colors.black,
                                            fw: FontWeight.w300,
                                          )),
                                    ],
                                  ),
                                ))
                          ]));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Row btnCourseRow(int chosenIndex) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomButton(
          text: "All",
          width: 15.swp,
          padding: EdgeInsets.symmetric(horizontal: 2.swp, vertical: 2.swp),
          fontSize: 12,
          backGroundColor:
              chosenIndex == 0 ? AppColors.mainBlue : Colors.blueGrey,
          textColor: Colors.white,
          onTap: () {},
        ),
        CustomButton(
          text: "Popular",
          padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 2.swp),
          fontSize: 12,
          backGroundColor:
              chosenIndex == 2 ? AppColors.mainBlue : Colors.blueGrey[200],
          textColor: Colors.white,
          onTap: () {},
        ),
        CustomButton(
          text: "Newest",
          padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 2.swp),
          fontSize: 12,
          backGroundColor:
              chosenIndex == 2 ? AppColors.mainBlue : Colors.blueGrey[200],
          textColor: Colors.white,
          onTap: () {},
        ),
      ],
    );
  }
}
