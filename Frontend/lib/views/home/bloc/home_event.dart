part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchHomeData extends HomeEvent {
  FetchHomeData();
}

class ChangePreviewIndex extends HomeEvent {
  final int index;

  ChangePreviewIndex(this.index);
}
