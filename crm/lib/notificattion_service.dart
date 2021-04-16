import 'dart:async';
import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';

class NotificationMessage {
  final String title;
  final String message;

  NotificationMessage(this.title, this.message);
}

class NotoficationService {
  static StompClient? _mSocket;
  static final onMessage = BehaviorSubject<NotificationMessage>();

  start() {
    if (_mSocket == null) {
      _mSocket = StompClient(
        config: StompConfig(
          url: socketUrl,
          onConnect: onConnect,
          beforeConnect: () async {
            await Future.delayed(Duration(milliseconds: 200));
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
          stompConnectHeaders: {},
          webSocketConnectHeaders: {},
        ),
      );
    }
    _mSocket?.activate();
  }

  onConnect(StompClient stompClient, StompFrame frame) {
    print("socket connected");
    final user = UserRepository.instance().myUserLiveData.value!;
    if (user.roleInfo() == RoleType.SUPER_ADMIN) {
      //_subcribeImportOrder();
    }
  }

  BehaviorSubject<ImportOrderProcessModel> subcribeImportOrder(String uuid) {
    BehaviorSubject<ImportOrderProcessModel> nMessage = BehaviorSubject();

    _mSocket?.subscribe(
      destination: '/topic/order/import/process',
      callback: (frame) {
        print("socket on ImportOrder");
        final _json = json.decode(frame.body);

        nMessage.add(ImportOrderProcessModel.fromJson(_json));
      },
    );

    return nMessage;
  }

  close() {
    onMessage.close();
  }
}

class ImportOrderProcessBrokeReason {
  final int index;
  final String reason;

  ImportOrderProcessBrokeReason(this.index, this.reason);

  ImportOrderProcessBrokeReason.fromJson(Map<String, dynamic> json) :
        index = json["index"],
        reason = json["reason"];
}

class ImportOrderProcessModel {
  final int process;
  final int max;
  final List<ImportOrderProcessBrokeReason> brokers;

  ImportOrderProcessModel(this.process, this.max, this.brokers);

  ImportOrderProcessModel.fromJson(Map<String, dynamic> json) :
      process = json["process"],
      max = json["max"],
      brokers = (json["brokers"] as List).map((e) => ImportOrderProcessBrokeReason.fromJson(e)).toList();
}
