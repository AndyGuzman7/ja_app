import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/unit_page_controller/unit_page_state.dart';
import 'package:ja_app/app/utils/email_service.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import '../../../../../data/repositories/church_repository/church_repository.dart';
import '../../../../../data/repositories/eess_repository/eess_repository.dart';
import '../../../../../data/repositories/target_virtual_repository/target_virtual_repository.dart';
import '../../../../../data/repositories/unitOfAction_repository/unitOfAction_repository.dart';
import '../../../../../data/repositories/user_repository/user_repository.dart';
import '../../../../global_controllers/session_controller.dart';

class UnitPageController extends StateNotifier<UnitPageState> {
  final SessionController _sessionController;
  final EeSsController _eeSsController;

  List<UserData> membersSelected = [];
  String? _routeName;
  String? get routeName => _routeName;
  final userRepository = Get.find<UserRepository>();

  final _targetVirtual = Get.find<TargetVirtualRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey formKey2 = GlobalKey();

  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();

  final _eess = Get.find<EESSRepository>();
  final _church = Get.find<ChurchRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  UnitPageController(this._sessionController, this._eeSsController)
      : super(UnitPageState.initialState);

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
    ProgressDialog.show(context, double.infinity, double.infinity);
    final response = await _unitOfAction.registerUnitOfAction(
        state.nameUnitOfActionCreate!,
        state.userDataUnitOfActionCreate!.id,
        _eeSsController.state.eess!.id!);

    final responseRegisterMember = await _unitOfAction
        .registerMemberUnitOfAction([state.userDataUnitOfActionCreate!.id],
            response!.idEESS, response.id);
    var listQuarter = await _eess.getEESSConfigQuarter();

    var dateTimeNow = DateTime.now();
    var quater = listQuarter.firstWhere((element) => verificationDateQuarter(
        element.startTime, element.endTime, dateTimeNow));

    await _targetVirtual.registerTargetVirtual(response.id, quater.id);
    router.pop(context);

    if (response != null && responseRegisterMember) {
      await Dialogs.alert(context,
          title: "Registro", content: "Registro exitoso");
      await loadPageData();
    } else {
      Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
    }
  }

  verificationDateQuarter(
      DateTime startTimeDate, DateTime endTimeDate, DateTime dateComparation) {
    var d = startTimeDate.isBefore(dateComparation) &&
        endTimeDate.isAfter(dateComparation);

    return d;
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
    final idEess = _eeSsController.state.eess!.id;

    final response = await _unitOfAction.registerMemberUnitOfAction(
        listIdS, idEess!, idUnitOfAction);

    if (response) {
      state = state.copyWith(membersUnitOfActionNew: []);

      await getMembersToUnitOfAction(state.unitOfAction!.id);
      // router.pop(context);
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

  void onChangedUnitOfAction(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfAction: unitOfAction);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    state = state.copyWith(listUnitOfAction: list);
    if (list.isNotEmpty) {
      onChangedUnitOfAction(list.first);
    }
  }

  void onChangedListMembersUnitOfAction(List<UserData> list) {
    state = state.copyWith(membersUnitOfAction: list);
  }

  void onChangedNameCreateUnitOfAction(String name) {
    state = state.copyWith(nameUnitOfActionCreate: name);
  }

  void onChangedUserDateCreateUnitOfAction(UserData user) {
    state = state.copyWith(userDataUnitOfActionCreate: user);
  }

  void onChangedIsAdmin(UserData admin) {
    state = state.copyWith(admin: admin);
  }

  void onChangedUnitOfActionLeader(UnitOfAction u) {
    state = state.copyWith(unitOfActionLeader: u);
  }

  void onChangedUnitOfActionMember(UnitOfAction u) {
    state = state.copyWith(unitOfActionMember: u);
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

  Future<List<UserData>>? getMembersToUnitOfAction(String idUnitAction) async {
    final response = await _unitOfAction.getMembersToUnitAction(idUnitAction);

    onChangedListMembersUnitOfAction(response);

    return response;
  }

  Future<List<UnitOfAction>> getUnitOfActionByEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final unitOfActions = await _unitOfAction.getUnitOfActionAllByEESS(idEESS!);
    return unitOfActions;
  }

  Future<List<UserData>>? getMembersNoneUnitOfAction() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response =
        await _unitOfAction.getMembersEESSNoneToUnitOfAction(idEESS!);
    return response;
  }

  Future loadPageData() async {
    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
    //return response;
  }

  onPressedBtnCreateMember(context) async {
    UserData userData = await router.pushNamed(Routes.REGISTER);
    ProgressDialog.show(context, double.infinity, double.infinity);
    final result = await createMemberToEESS(userData);
    if (result) await loadPageData();
    router.pop();
  }

  registerMembersToChurch(String idMember) async {
    final idEESS = _eeSsController.state.eess!.id;
    final idChurch = await _church.getChurchByEESS(idEESS!);

    final response = await _church.registerMemberChurch(idMember, idChurch!.id);
    return response;
  }

  Future<bool> registerMembersToEESS(List<String> list) async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.registerMembersEESS(list, idEESS!);
    return response;
  }

  createMemberToEESS(UserData userData) async {
    final responseChurch = await registerMembersToChurch(userData.id);
    final idEESS = _eeSsController.state.eess!.id;
    final String idUnitOfAction = state.unitOfAction!.id;
    if (!responseChurch) return false;
    final response = await registerMembersToEESS([userData.id]);
    if (!response) return false;

    final responseUnit = await _unitOfAction
        .registerMemberUnitOfAction([userData.id], idEESS!, idUnitOfAction);
    if (!responseUnit) return false;
    return response;
  }

  Future verificationPersmissons(List<String> listPermisson) async {
    bool permissonAdminPage = listPermisson.contains("adminEESS");
    bool permissonAdmin = listPermisson.contains("A");

    if (permissonAdminPage || permissonAdmin) {
      await loadPageData();
      onChangedIsAdmin(_sessionController.userData!);
      return;
    }
    final idUser = _sessionController.userData!.id;
    final isLeader = await _unitOfAction.isLeaderToUnitOfAction(idUser);

    if (isLeader != null) {
      onChangedUnitOfActionLeader(isLeader);
      onChangedUnitOfAction(isLeader);
      return;
    }

    final isMember = await _unitOfAction.isMemberToUnitOfAction(idUser);
    if (isMember != null) {
      onChangedUnitOfActionMember(isMember);
      onChangedUnitOfAction(isMember);
    }

    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
    //return response;
  }

  Future<UserData?> getUser(String idUser) async {
    UserData? data;
    try {
      data = await userRepository.getUser(idUser);
      return data!;
    } catch (e) {
      return null;
    }
  }

  sendEmail() async {
    EmailService emailService = EmailService("andyguzman117@gmail.com",
        "Registro de miembro " + DateTime.now().toString(), "");
    await emailService.sendEmail();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> signIng() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }

  static Future signOut() => _googleSignIn.signOut();
}
