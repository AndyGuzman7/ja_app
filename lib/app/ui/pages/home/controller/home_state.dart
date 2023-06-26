import 'package:ja_app/app/domain/models/user_data.dart';

class HomeState {
  final UserData? userData;
  final int currentTab;
  final String title;

  HomeState({
    required this.title,
    required this.currentTab,
    required this.userData,
  });

  static HomeState get initialState => HomeState(
        title: 'Inicio',
        currentTab: 0,
        userData: null,
      );

  HomeState copyWith({
    UserData? userData,
    int? currentTab,
    String? title,
  }) {
    return HomeState(
        currentTab: currentTab ?? this.currentTab,
        userData: userData ?? this.userData,
        title: title ?? this.title);
  }
}
