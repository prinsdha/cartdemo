import 'dart:async';

import 'package:get/get.dart';
import 'package:interviewtask/ui/shared/app_event/app_event.dart';

AppController appController = Get.find<AppController>();

class AppController extends GetxController {
  late StreamSubscription streamSubscription;
  final StreamController<AppEvent> _appEventStream =
      StreamController.broadcast();

  Stream<AppEvent> get appEventStream => _appEventStream.stream;

  void addAppEvent(AppEvent appEvent) {
    _appEventStream.add(appEvent);
  }
}
