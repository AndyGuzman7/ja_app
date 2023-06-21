import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class MembersPageState {
  final UnitOfAction? unitOfAction;
  final List<UnitOfAction> listUnitOfAction;
  final String? nameUnitOfActionCreate;
  final UserData? userDataUnitOfActionCreate;
  final List<UserData> membersEESSNew;
  final List<UserData> membersEESS;
  final List<UserData>? membersEESSNone;

  MembersPageState({
    required this.membersEESSNone,
    required this.membersEESS,
    required this.membersEESSNew,
    required this.listUnitOfAction,
    required this.userDataUnitOfActionCreate,
    required this.nameUnitOfActionCreate,
    required this.unitOfAction,
  });

  static MembersPageState get initialState => MembersPageState(
        membersEESSNone: [],
        membersEESS: [],
        membersEESSNew: [],
        listUnitOfAction: [],
        nameUnitOfActionCreate: null,
        userDataUnitOfActionCreate: null,
        unitOfAction: null,
      );

  MembersPageState copyWith({
    List<UserData>? membersEESSNone,
    List<UnitOfAction>? listUnitOfAction,
    UnitOfAction? unitOfAction,
    List<UserData>? membersEESS,
    List<UserData>? membersEESSNew,
    String? nameUnitOfActionCreate,
    UserData? userDataUnitOfActionCreate,
  }) {
    return MembersPageState(
      membersEESSNone: membersEESSNone ?? this.membersEESSNone,
      membersEESS: membersEESS ?? this.membersEESS,
      membersEESSNew: membersEESSNew ?? this.membersEESSNew,
      unitOfAction: unitOfAction ?? this.unitOfAction,
      listUnitOfAction: listUnitOfAction ?? this.listUnitOfAction,
      nameUnitOfActionCreate:
          nameUnitOfActionCreate ?? this.nameUnitOfActionCreate,
      userDataUnitOfActionCreate:
          userDataUnitOfActionCreate ?? this.userDataUnitOfActionCreate,
    );
  }

  /*EeSsState copyWithBoolean({
    bool? isSuscribeEESS,
    bool? isSuscribeChurch,
    bool? isOk,
  }) {
    log("stado");
    return EeSsState(
      isSuscribeEESSs: isSuscribeEESSs ?? this.isSuscribeEESSs,
      isOk: isOk ?? this.isOk,
      titleSearch: titleSearch ?? this.titleSearch,
      eess: eess ?? this.eess,
      eessSelected: eessSelected ?? this.eessSelected,
      isSuscribeChurch: isSuscribeChurch ?? this.isSuscribeChurch,
      isSuscribeEESS: isSuscribeEESS ?? this.isSuscribeEESS,
      listTabBarView: listTabBarView ?? this.listTabBarView,
      listTabr: listTabr ?? this.listTabr,
      imageUser: imageUser ?? this.imageUser,
    );
  }*/
}
