import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/church_impl/church_repository.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
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
import 'package:ja_app/app/ui/pages/eess/widgets/unit_page_eess.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../data/repositories/user_impl/login_impl/authentication_repository.dart';
import '../../../../data/repositories_impl/user/user_repository_impl.dart';
import '../../../global_controllers/session_controller.dart';

class EeSsController extends StateNotifier<EeSsState> {
  SessionController _sessionController;
  String? _routeName;
  String? get routeName => _routeName;

  final GlobalKey<FormState> formKey = GlobalKey();
  final _church = Get.find<ChurchRepository>();
  final _eess = Get.find<EESSRepository>();
  EeSsController(this._sessionController) : super(EeSsState.initialState) {
    init();
  }

  init() {
    List<TabBarUi> listTabBar = [
      TabBarUi(
        "Principal",
        MainPageEess(provider: eeSsProvider),
        null,
      ),
      TabBarUi(
        "Miembros",
        MembersPageEESS(
          providers: eeSsProvider,
        ),
        "adminEESS",
      ),
      TabBarUi(
        "Unidades",
        UnitPageEESS(),
        "adminEESS",
      ),
      TabBarUi(
        "Tarjeta",
        Center(child: Text("HOLA")),
        "adminEESS",
      ),
    ];
    List<Tab> listNew = [];
    List<Widget> listNewTabBarView = [];

    for (var element in listTabBar) {
      final object =
          _sessionController.userData!.listPermisson.contains("adminEESS");

      String permissonType =
          _sessionController.userData!.listPermisson.contains("adminEESS")
              ? "adminEESS"
              : "F";

      if (element.permissons == null) {
        listNew.add(element.tabBar);
        listNewTabBarView.add(element.tabBarView);
      }
      log(object.toString());
      if (permissonType == element.permissons) {
        listNew.add(element.tabBar);
        listNewTabBarView.add(element.tabBarView);
      }
    }
    onChangedListTabBar(listNew);
    onChangedListTabBarView(listNewTabBarView);
  }

  onChangedListTabBar(list) {
    state = state.copyWith(listTabr: list);
  }

  onChangedListTabBarView(list) {
    state = state.copyWith(listTabBarView: list);
  }

  onChangedIsSuscribe(bool isSsucribe) {
    log("suscribe");
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

  Future<void> loadSuscriptionAndEESS() async {
    final eess = await getEESSSuscription();
    onChangedEESS(eess!);
    onChangedIsSuscribe(true);
    onChangedIsSuscribreEESSs(1);
  }

  Future<void> isExistSuscription() async {
    try {
      final idUser = _sessionController.userData!.id;
      final responseEESS = await _eess.isExistEESSSuscripcion(idUser);
      final responseChurch = await _church.isExistChurchSuscripcion(idUser);

      if (responseChurch != null) {
        onChangedIsSuscribeChurch(true);
        if (responseEESS != null) {
          await loadSuscriptionAndEESS();
        }
      }

      log("sigueee");
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

  Future<EESS?> getEESSSuscription() async {
    final idUser = _sessionController.userData!.id;
    final response = await _eess.getEESSWitdhIdMember(idUser);
    return response;
  }

  onPressedGoToThePanel(context) {
    router.popAndPushNamed(Routes.CHURCH);
  }

  onRegisterEESS(context) async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        final idUser = _sessionController.userData!.id;
        ProgressDialog.show(context);

        final response =
            await _eess.registerMemberEESS(idUser, state.eess!.id!);
        router.pop();

        if (!response) {
          Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
        } else {
          Navigator.pop(context);
          await Dialogs.alert(context,
              title: "Registro", content: "Registro exitoso");

          await loadSuscriptionAndEESS();
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
      if (eess.unitOfAction.isNotEmpty) {
        log("no vacio");
        onChangedUnitOfAction(eess.unitOfAction.first);
      }
    }
    return eess;
  }

  Future<List<UserData>>? getMembersToUnitOfAction(String idUnitAction) async {
    final idUser = state.eess!.id;
    final eess = await _eess.getMembersToUnitAction(idUnitAction, idUser!);
    //if (eess != null) onChangedEESS(eess);
    return eess;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
