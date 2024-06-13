import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/online/pages/chatting/chatting_view.dart';
import 'package:e_learning_app/views/online/pages/streaming/streaming_view.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: ReusableText(
              "Online",
              style:
                  appStyle(size: 18, color: Colors.black, fw: FontWeight.w500),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
            bottom: const TabBar(
              labelColor: AppColors.mainBlue,
              indicatorColor: AppColors.mainBlue,
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                        "Chatting  ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.chat_rounded,
                      ),
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                        "Streaming  ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.video_camera_front_rounded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ChattingPage(),
              StreamingPage(),
            ],
          )),
    );
  }
}
