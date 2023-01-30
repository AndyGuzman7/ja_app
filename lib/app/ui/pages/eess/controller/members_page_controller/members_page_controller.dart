import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';

import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../global_controllers/session_controller.dart';

final membersPageProvider =
    StateProvider<MembersPageController, MembersPageState>(
        (_) => MembersPageController(sessionProvider.read, eeSsProvider.read),
        autoDispose: true);

class MembersPageController extends StateNotifier<MembersPageState> {
  final SessionController _sessionController;
  final EeSsController _eeSsController;
  List<UserData> membersSelected = [];
  String? _routeName;
  String? get routeName => _routeName;
  final userRepository = Get.find<UserRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey formKey2 = GlobalKey();

  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();

  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  MembersPageController(this._sessionController, this._eeSsController)
      : super(MembersPageState.initialState);

  onPressedRegisterUnitOfAction(context) async {
    final isReady = formKeyRegisterUnitOfAction.currentState;

    if (isReady != null) {
      final validator = formKeyRegisterUnitOfAction.currentState!.validate();
      if (validator) {
        await registerUnitOfAction(context);
        router.pop(context);
      }
    }
  }

  Future registerUnitOfAction(context) async {
    ProgressDialog.show(context);

    final response = await _unitOfAction.registerUnitOfAction(
        state.nameUnitOfActionCreate!,
        state.userDataUnitOfActionCreate!.id,
        _eeSsController.state.eess!.id!);
    router.pop(context);

    if (response != null) {
      await Dialogs.alert(context,
          title: "Registro", content: "Registro exitoso");
      await loadPageData();
    } else {
      Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
    }
  }

  onChangedListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.contains(user)
        ? removeListMembersSelected(user)
        : addListMembersSelected(user);
  }

  onPressedAddMembers(context) async {
    ProgressDialog.show(context);
    final List<UserData> list = state.membersEESSNew;

    List<String> listIdS = [];
    for (var element in list) {
      listIdS.add(element.id);
    }
    final idEess = _eeSsController.state.eess!.id;

    final response = await _eess.registerMembersEESS(listIdS, idEess!);

    if (response) {
      state = state.copyWith(membersEESSNew: []);
      await loadPageData();
    }
    router.pop(context);
  }

  addListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.add(user);
    state = state.copyWith(membersEESSNew: list);
  }

  removeListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.remove(user);
    state = state.copyWith(membersEESSNew: list);
  }

  void onChangedUnitOfAction(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfAction: unitOfAction);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    state = state.copyWith(listUnitOfAction: list);
    if (list.isNotEmpty) {
      onChangedUnitOfAction(list.first);
    }
  }

  void onChangedNameCreateUnitOfAction(String name) {
    state = state.copyWith(nameUnitOfActionCreate: name);
  }

  void onChangedUserDateCreateUnitOfAction(UserData user) {
    state = state.copyWith(userDataUnitOfActionCreate: user);
  }

  Future<List<UserData>> getListMembers() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getUnitOfAction() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getMembersEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.getMembersEESS(idEESS!);
    return response;
  }

  Future<List<UserData>>? getMembersNoneEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.getMembersChurchNoneEESS(
        idEESS!, _eeSsController.state.church!.id);
    return response;
  }

  Future loadPageData() async {
    final response = await getMembersEESS();
    onChangedMembersEESS(response);
  }

  void onChangedMembersEESS(List<UserData> list) {
    state = state.copyWith(membersEESS: list);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
