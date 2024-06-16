part of 'chatting_cubit.dart';

@immutable
sealed class ChattingState {}

final class ChattingInitial extends ChattingState {}

final class ChattingConnecting extends ChattingState {}

final class ChattingConnected extends ChattingState {}
