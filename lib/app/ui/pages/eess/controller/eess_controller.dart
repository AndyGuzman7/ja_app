import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/church_impl/church_repository.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/tabBarUi.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/main_page_eess.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/members_page_eess.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/target_page_eess.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/unit_page_eess.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../data/repositories/user_impl/login_impl/authentication_repository.dart';
import '../../../../data/repositories_impl/user/user_repository_impl.dart';
import '../../../global_controllers/session_controller.dart';

class EeSsController extends StateNotifier<EeSsState> {
  SessionController _sessionController;
  List<UserData> membersSelected = [];
  String? _routeName;
  String? get routeName => _routeName;

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey formKey2 = GlobalKey();

  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();
  final _church = Get.find<ChurchRepository>();
  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  EeSsController(this._sessionController) : super(EeSsState.initialState) {
    init();
  }

  init() {
    log("el init");
    List<String> listPermisson = _sessionController.userData!.listPermisson;
    List<TabBarUi> listTabBar = [
      TabBarUi(
        "Mi EESS",
        null,
        MainPageEess(provider: eeSsProvider),
        null,
      ),
      TabBarUi(
        "Miembros",
        null,
        MembersPageEESS(
          providers: eeSsProvider,
        ),
        "adminEESS",
      ),
      TabBarUi(
        "Unidades",
        null,
        UnitPageEESS(
          listPermissons: listPermisson,
        ),
        null,
      ),
      TabBarUi(
        "Tarjeta",
        null,
        const TargetPageEESS(),
        "adminEESS",
      ),
    ];

    bool permissonAdminPage = listPermisson.contains("adminEESS");
    bool permissonAdmin = listPermisson.contains("A");
    log(permissonAdmin.toString() + "" + permissonAdminPage.toString());
    if (permissonAdmin || permissonAdminPage) {
      onChangedListTabBar(listTabBar.map((e) => e.tabBar).toList());
      onChangedListTabBarView(listTabBar.map((e) => e.tabBarView).toList());
      return;
    }
    List<TabBarUi> listTBNew =
        listTabBar.where((value) => value.permissons == null).toList();

    onChangedListTabBar(listTBNew.map((e) => e.tabBar).toList());
    onChangedListTabBarView(listTBNew.map((e) => e.tabBarView).toList());
  }

  onChangedListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.contains(user)
        ? removeListMembersSelected(user)
        : addListMembersSelected(user);
  }

  onPressedAddMembers(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);
    final List<UserData> list = state.membersUnitOfActionNew;
    final String idUnitOfAction = state.unitOfAction!.id;

    List<String> listIdS = [];
    for (var element in list) {
      listIdS.add(element.id);
    }
    final idEess = state.eess!.id;

    final response = await _unitOfAction.registerMemberUnitOfAction(
        listIdS, idEess!, idUnitOfAction);

    if (response) {
      state = state.copyWith(membersUnitOfActionNew: []);

      await getUnitOfActionByEESS();
      router.pop(context);
    }
    router.pop(context);
  }

  addListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.add(user);
    state = state.copyWith(membersUnitOfActionNew: list);
  }

  removeListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.remove(user);
    state = state.copyWith(membersUnitOfActionNew: list);
  }

  onChangedListTabBar(list) {
    state = state.copyWith(listTabr: list);
  }

  onChangedUserDateCreateUnitOfAction(list) {
    state = state.copyWith(userDataUnitOfActionCreate: list);
  }

  onChangedNameCreateUnitOfAction(list) {
    state = state.copyWith(nameUnitOfActionCreate: list);
  }

  onChangedListTabBarView(list) {
    state = state.copyWith(listTabBarView: list);
  }

  onChangedIsSuscribe(bool isSsucribe) {
    state = state.copyWith(isSuscribeEESS: isSsucribe);
  }

  onChangedIsSuscribeChurch(bool isSuscribeChurch) {
    state = state.copyWith(isSuscribeChurch: isSuscribeChurch);
  }

  onChangedIsSuscribreEESSs(int suscribre) {
    state = state.copyWith(isSuscribeEESSs: suscribre);
  }

  onChangedEESS(EESS eess) {
    state = state.copyWith(eess: eess);
  }

  onChangedMembersOfAction(List<UserData> members) {
    state = state.copyWith(membersUnitOfAction: members);
  }

  onChangedEESSSelected(EESS eess) {
    state = state.copyWith(eessSelected: eess);
  }

  void onChangedTitleSearch(String title) {
    state = state.copyWith(titleSearch: title);
  }

  void onChangedIsOk(bool title) {
    state = state.copyWith(isOk: title);
  }

  void onChangedUnitOfAction(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfAction: unitOfAction);
  }

  void onChangedChurch(Church church) {
    state = state.copyWith(church: church);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    dynamic s = list;
    state = state.copyWith(listUnitOfAction: s);
  }

  Future<void> loadDataChurchEESS() async {
    final church = await getcHURCHByMember();
    final eess = await getEESSByMember();
    onChangedChurch(church!);
    onChangedEESS(eess!);
  }

  Future<void> getChurchAndEESS() async {
    try {
      final idUser = _sessionController.userData!.id;
      final responseChurch = await _church.isExistChurchSuscripcion(idUser);
      final responseEESS = await _eess.isExistEESSSuscripcion(idUser);

      if (responseChurch != null) {
        final church = await getcHURCHByMember();
        onChangedChurch(church!);
      }
      if (responseEESS != null) {
        final eess = await getEESSByMember();
        onChangedEESS(eess!);
      }
      //await loadDataChurchEESS();
    } catch (e) {
      return;
    }
  }

  Future<List<UserData>> getListMembers() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getUnitOfAction() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(state.eess!.id!);
    return listUserData;
  }

  Future<EESS?> getEESSByMember() async {
    final idUser = _sessionController.userData!.id;
    final response = await _eess.getEESSWitdhIdMember(idUser);
    return response;
  }

  Future<Church?> getcHURCHByMember() async {
    final idUser = _sessionController.userData!.id;
    final response = await _church.getChurchWitdhIdMember(idUser);
    return response;
  }

  onPressedGoToThePanel(context) {
    router.popAndPushNamed(Routes.CHURCH);
  }

  onRegisterEESS(context) async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        final idUser = _sessionController.userData!.id;
        ProgressDialog.show(context, double.infinity, double.infinity);

        final response =
            await _eess.registerMemberEESS(idUser, state.eessSelected!.id!);
        router.pop();

        if (!response) {
          Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
        } else {
          router.pop();
          await Dialogs.alert(context,
              title: "Registro", content: "Registro exitoso");
          onChangedEESS(state.eessSelected!);

          //final response = await getUnitOfActionByEESS();
          //onChangedListUnitOfAction(response);
        }
      }
    }
  }

  Future<List<EESS>> getEESSs() async {
    final idUser = _sessionController.userData!.id;
    final church = await _church.getChurchWitdhIdMember(idUser);
    final eess = await _eess.getEESSByChurch(church!.id);
    return eess;
  }

  Future<EESS?> getEESS() async {
    final idUser = state.eess!.id;
    final eess = await _eess.getEESS(idUser!);

    if (eess != null) {
      onChangedEESS(eess);
    }
    return eess;
  }

  Future<List<UserData>>? getMembersToUnitOfAction(String idUnitAction) async {
    final eess = await _unitOfAction.getMembersToUnitAction(idUnitAction);

    return eess;
  }

  Future<List<UnitOfAction>> getUnitOfActionByEESS() async {
    final idEESS = state.eess!.id;
    final unitOfActions = await _unitOfAction.getUnitOfActionAllByEESS(idEESS!);
    return unitOfActions;
  }

  Future<List<UserData>>? getMembersNoneUnitOfAction(
      String idUnitAction) async {
    final idEESS = state.eess!.id;
    final response =
        await _unitOfAction.getMembersEESSNoneToUnitOfAction(idEESS!);
    return response;
  }

  Future loadPageData() async {
    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
