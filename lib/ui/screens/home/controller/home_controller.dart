import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:interviewtask/ui/app_controller.dart';
import 'package:interviewtask/ui/screens/home/model/items_model.dart';
import 'package:interviewtask/ui/shared/app_event/app_event.dart';

import '../../../../core/data/repository/user_repo.dart';

class HomeController extends GetxController {
  final repo = GetIt.I.get<UserRepo>();

  ItemsModel? items;

  List<TableMenuList> get categories => items!.tableMenuList;
  late StreamSubscription<AppEvent> _appEventSubscription;

  UiFailure? uiFailure;

  bool isLoading = false;

  Future<void> fetchItems() async {
    uiFailure = null;
    isLoading = true;
    update();
    try {
      final request = await repo.getItems();
      items = request.first;
    } catch (error, stackTrace) {
      uiFailure = UiFailure(error);
    } finally {
      isLoading = false;
      update();
    }
  }

  void _addCartEventStream() {
    _appEventSubscription = appController.appEventStream.listen((event) {
      event.maybeWhen(
          orElse: () {},
          clearCart: () {
            for (var element in categories) {
              for (var e in element.categoryDishes) {
                e.count = 0;
              }
            }
            update();
          },
          cartUpdate: (dish, count) {
            for (var element in categories) {
              for (var e in element.categoryDishes) {
                if (e.dishId == dish.dishId) {
                  e.count = count;
                  update();
                  break;
                }
              }
            }
          });
    });
  }

  @override
  void onInit() {
    fetchItems();

    _addCartEventStream();
    super.onInit();
  }

  @override
  void onClose() {
    _appEventSubscription.cancel();
    super.onClose();
  }
}

class UiResult<T> {
  final T data;

  UiResult(this.data);
}

class UiSuccess extends UiResult {
  UiSuccess(super.data);
}

class UiFailure extends UiResult {
  UiFailure(super.data);
}
