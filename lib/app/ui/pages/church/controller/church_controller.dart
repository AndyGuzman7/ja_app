import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/church/church.dart';

import '../../../../data/repositories/church_impl/church_repository.dart';
import '../../../global_controllers/session_controller.dart';
import '../../../gobal_widgets/dialogs/dialogs.dart';
import '../../../gobal_widgets/dialogs/progress_dialog.dart';
import 'church_state.dart';

final churchProvider = StateProvider<ChurchController, ChurchState>(
    (_) => ChurchController(sessionProvider.read));

class ChurchController extends StateNotifier<ChurchState> {
  final SessionController _sessionController;

  final GlobalKey<FormState> formKey = GlobalKey();
  final _church = Get.find<ChurchRepository>();
  ChurchController(
    this._sessionController,
  ) : super(ChurchState.initialState);

  Future<void> getChurchSuscription() async {
    final response =
        await _church.isExistChurchSuscripcion(_sessionController.userData!.id);
    if (response != null) {
      onChangedIsSuscribe(true);
      onChangedChurch(response);
    }
  }

  void onChangedCodeAccess(String text) {
    state = state.copyWith(codeAccess: text);
  }

  void onChangedChurch(Church church) {
    state = state.copyWith(church: church);
  }

  void onChangedIsSuscribe(bool text) {
    state = state.copyWith(isSuscribe: text);
  }

  onRegister(context) {
    final validator = formKey.currentState!.validate();
    if (validator) {
      registerChurch(context);
    }
  }

  Future registerChurch(context) async {
    FocusScope.of(context).unfocus();
    ProgressDialog.show(context);

    final response = await _church.registerMemberChurchCodeAcess(
        _sessionController.userData!.id, state.codeAccess);
    router.pop();
    log(response.toString() + "sdasdasdd");

    if (!response) {
      Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
    } else {
      Navigator.pop(context);
      await Dialogs.alert(context,
          title: "Registro", content: "Registro exitoso");
      getChurchSuscription();
      //onChangedIsSuscribe(true);
    }
    return response;
  }
}
