import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/online/pages/chatting/chatting_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final ChattingCubit _chattingCubit = ChattingCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChattingCubit, ChattingState>(
      bloc: _chattingCubit,
      builder: (context, state) {
        if (state is ChattingConnecting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ChattingConnected) {
          return ZIMKitConversationListView(
            onPressed: (context, conversation, defaultAction) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ZIMKitMessageListPage(
                    conversationID: conversation.id,
                    conversationType: conversation.type,
                    messageItemBuilder: (context, message, defaultWidget) {
                      return Theme(
                        data: ThemeData(primaryColor: AppColors.mainBlue),
                        child: defaultWidget,
                      );
                    },
                    inputDecoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Type a message'),
                  );
                },
              ));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
