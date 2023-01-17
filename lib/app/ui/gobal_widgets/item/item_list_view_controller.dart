import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view_state.dart';

final itemListViewProvider =
    StateProvider<ItemListViewController, ItemListViewState>(
        (_) => ItemListViewController(sessionProvider.read));

class ItemListViewController extends StateNotifier<ItemListViewState> {
  final SessionController _sessionController;

  final GlobalKey<FormState> formKey = GlobalKey();
  ItemListViewController(
    this._sessionController,
  ) : super(ItemListViewState.initialState);

  void onChangedIsSelected(int text) {
    log(text.toString());
    state = state.copyWith(isSelected: text);
  }

  onRegister(context) {
    final validator = formKey.currentState!.validate();
    if (validator) {
      //registerChurch(context);
    }
  }

  @override
  // TODO: implement disposed
  bool get disposed => super.disposed;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("se muere");
  }
}
