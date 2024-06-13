import 'package:e_learning_app/utils/export.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ReusableText(
        "Chatting",
        style: appStyle(size: 18, color: Colors.black, fw: FontWeight.w500),
      ),
    );
  }
}
