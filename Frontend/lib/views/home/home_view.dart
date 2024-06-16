import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/common/custom_textfield.dart';
import 'package:e_learning_app/constants/enum.dart';
import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/course/course_detail/course_detail_view.dart';
import 'package:e_learning_app/views/home/bloc/home_bloc.dart';
import 'package:e_learning_app/views/home/home_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  List<String> coursesRecommendation = [
    Assets.imagesRcmCourse1,
    Assets.imagesRcmCourse2,
    Assets.imagesRcmCourse3,
  ];
  int rcmCourseIndex = 0;
  int chosenIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomeData());
  }

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
              onPressed: () {
                Get.toNamed(Routes.PROFILE);
              },
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
                        Global.storageService.currentUser!.username,
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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.apiStatus) {
                      case ApiStatus.loading:
                        return Center(
                            child: Container(
                                padding: EdgeInsets.only(top: 5.swp),
                                child: const CircularProgressIndicator()));
                      case ApiStatus.error:
                        return const Center(child: Text("Error"));
                      case ApiStatus.success:
                        return Column(
                          children: [
                            btnCourseRow(state.indexPreview),
                            Gap(1.shp),
                            SizedBox(
                              height: 62.shp,
                              child: GridView.builder(
                                itemCount: state.previewList.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 2.5.swp,
                                        mainAxisSpacing: 2.5.swp,
                                        mainAxisExtent: 60.swp,
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.6),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => const CourseDetail(),
                                          arguments:
                                              state.previewList[index].id);
                                    },
                                    child: Card(
                                      elevation: 3,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                          height: 31.shp,
                                          width: 60.swp,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(children: [
                                            Positioned(
                                              top: 0,
                                              child: SizedBox(
                                                height: 15.shp,
                                                width: 60.swp,
                                                child: Image.network(
                                                  state.previewList[index]
                                                      .thumbnail,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.all(2.swp),
                                                  color: Colors.white,
                                                  width: 60.swp,
                                                  height: 16.shp,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ReusableText(
                                                              state
                                                                  .previewList[
                                                                      index]
                                                                  .title,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              maxLines: 2,
                                                              style: appStyle(
                                                                size: 15,
                                                                color: Colors
                                                                    .black,
                                                                fw: FontWeight
                                                                    .w600,
                                                              )),
                                                          ReusableText(
                                                              state
                                                                  .previewList[
                                                                      index]
                                                                  .author,
                                                              style: appStyle(
                                                                size: 9,
                                                                color: Colors
                                                                    .black,
                                                                fw: FontWeight
                                                                    .w300,
                                                              )),
                                                          state
                                                                      .previewList[
                                                                          index]
                                                                      .courseScore ==
                                                                  null
                                                              ? ReusableText(
                                                                  "No rating",
                                                                  style:
                                                                      appStyle(
                                                                    size: 9,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade400,
                                                                    fw: FontWeight
                                                                        .w200,
                                                                  ))
                                                              : RatingBarIndicator(
                                                                  rating: state
                                                                      .previewList[
                                                                          index]
                                                                      .courseScore!,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  itemCount: 5,
                                                                  itemSize: 12,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                ),
                                                          Gap(0.7.swp),
                                                          Row(
                                                            children: [
                                                              state
                                                                  .previewList[
                                                                      index]
                                                                  .categories
                                                                  .map((e) =>
                                                                      Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                1.swp,
                                                                            vertical: 0.5.swp),
                                                                        // margin: EdgeInsets.symmetric(
                                                                        //     horizontal:
                                                                        //         1.swp),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                              color: AppColors.mainBlue,
                                                                              width: 1),
                                                                        ),
                                                                        child: Text(
                                                                            e,
                                                                            style: appStyle(
                                                                                size: 10,
                                                                                color: AppColors.mainBlue,
                                                                                fw: FontWeight.w200)),
                                                                      ))
                                                                  .toList()[0],
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ReusableText(
                                                              state.previewList[index]
                                                                          .coursePrice ==
                                                                      0
                                                                  ? "Free"
                                                                  : "\$${state.previewList[index].coursePrice}",
                                                              style: appStyle(
                                                                size: 15,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fw: FontWeight
                                                                    .w600,
                                                              )),
                                                          Gap(3.swp),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ])),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                    }
                  },
                ),
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
              chosenIndex == 0 ? AppColors.mainBlue : Colors.blueGrey[200],
          textColor: Colors.white,
          onTap: () {
            context.read<HomeBloc>().add(ChangePreviewIndex(0));
          },
        ),
        CustomButton(
          text: "Popular",
          padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 2.swp),
          fontSize: 12,
          backGroundColor:
              chosenIndex == 1 ? AppColors.mainBlue : Colors.blueGrey[200],
          textColor: Colors.white,
          onTap: () {
            context.read<HomeBloc>().add(ChangePreviewIndex(1));
          },
        ),
        CustomButton(
          text: "Newest",
          padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 2.swp),
          fontSize: 12,
          backGroundColor:
              chosenIndex == 2 ? AppColors.mainBlue : Colors.blueGrey[200],
          textColor: Colors.white,
          onTap: () {
            context.read<HomeBloc>().add(ChangePreviewIndex(2));
          },
        ),
      ],
    );
  }
}
