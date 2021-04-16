import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/widget/HelpMessageBubleWidget.dart';

abstract class ZakazyViewModel {
  final helpMessageData = BehaviorSubject<HelpMessageBubble>();
  close();
}
