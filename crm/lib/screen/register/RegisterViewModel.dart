import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';

class RegisterViewModel {
  static RegisterViewModel? instance;

  static RegisterViewModel create() {
    if (instance == null) instance = RegisterViewModel();

    return instance ?? RegisterViewModel();
  }

  final _userRepository = UserRepository.instance();

  RoleType selectedRole = RoleType.CLIENT;

  String? phoneToken;

  registerStep1(String email) async {
    this.phoneToken =
        await _userRepository.registerStep1(email, selectedRole);

    return phoneToken != null;
  }

  registerStep2(String code) async {
    final smsToken = await _userRepository.registerStep2(code, this.phoneToken ?? "", selectedRole);

    if (smsToken != null) {
      this.phoneToken = smsToken;
      return true;
    } else {
      return false;
    }
  }

  registerStep3(
      String firstName,
      String lastName,
      String middleName,
      String phoneNumber,
      String password) async {
    final data = await _userRepository.registerStep3(phoneToken ?? "", firstName,
        lastName, middleName, phoneNumber, password, selectedRole);

    return data;
  }
}
