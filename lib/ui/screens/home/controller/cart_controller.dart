import 'dart:async';

import 'package:get/get.dart';
import 'package:interviewtask/core/const/app_settings.dart';
import 'package:interviewtask/ui/app_controller.dart';
import 'package:interviewtask/ui/screens/home/model/items_model.dart';
import 'package:interviewtask/ui/shared/app_event/app_event.dart';

class CartController extends GetxController {
  Map<String, CategoryDish> cartItems = {};

  late StreamSubscription<AppEvent> _appEventSubscription;

  void addToCart(CategoryDish categoryDish) {
    if (cartItems.containsKey(categoryDish.dishId)) {
      cartItems.update(categoryDish.dishId, (value) => categoryDish);
    } else {
      cartItems.putIfAbsent(categoryDish.dishId, () => categoryDish);
    }
    update();
  }

  void removeCart(CategoryDish categoryDish) {
    if (categoryDish.count != 0) {
      cartItems.update(categoryDish.dishId, (value) => categoryDish);
    } else {
      cartItems.remove(categoryDish.dishId);
    }
    update();
  }

  int get count => cartItems.length;

  int get itemCount {
    int c = 0;
    for (var element in cartItems.values) {
      c = c + element.count;
    }
    return c;
  }

  double get totalPrice {
    double c = 0;
    for (var element in cartItems.values) {
      c = c + (element.dishPrice * element.count);
    }
    return c * sapPrice;
  }

  void clearCart() {
    cartItems.clear();
    appController.addAppEvent(const AppEvent.clearCart());
    update();
  }

  void _addCartEventStream() {
    _appEventSubscription = appController.appEventStream.listen((event) {
      event.maybeWhen(
          orElse: () {},
          cartUpdate: (dish) {
            if (dish.count == 0) {
              cartItems.remove(dish.dishId);
            } else {
              addToCart(dish);
            }
          });

      update();
    });
  }

  @override
  void onInit() {
    _addCartEventStream();
    super.onInit();
  }

  @override
  void onClose() {
    _appEventSubscription.cancel();
    super.onClose();
  }
}
