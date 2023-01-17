import 'dart:developer';

import 'package:ja_app/app/domain/models/church/church.dart';

class ItemListViewState {
  final int? isSelected;

  ItemListViewState({
    required this.isSelected,
  });

  static ItemListViewState get initialState => ItemListViewState(
        isSelected: 0,
      );

  ItemListViewState copyWith({int? isSelected}) {
    // log("asdadasd");
    return ItemListViewState(isSelected: isSelected ?? this.isSelected);
  }
}
