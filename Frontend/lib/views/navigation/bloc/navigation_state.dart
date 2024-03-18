part of 'navigation_bloc.dart';

class NavigationState {
  final int currentPage;

  NavigationState({this.currentPage = 0});

  NavigationState copyWith(int currentPage) {
    return NavigationState(currentPage: currentPage);
  }
}
