import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class RussianPhoneNumberFormat extends MaskedInputFormater {
  RussianPhoneNumberFormat() : super("+7##########");
}
