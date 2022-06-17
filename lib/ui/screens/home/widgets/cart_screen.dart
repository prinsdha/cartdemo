import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewtask/core/const/app_settings.dart';
import 'package:interviewtask/ui/app_controller.dart';
import 'package:interviewtask/ui/screens/home/controller/cart_controller.dart';
import 'package:interviewtask/ui/shared/app_event/app_event.dart';

import '../../../../core/const/app_icon.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Order summary",
            style: TextStyle(color: Colors.grey.shade600),
          )),
      body: GetBuilder(
        builder: (CartController controller) {
          return ListView(
            padding: const EdgeInsets.only(top: 10),
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: const [BoxShadow()],
                    color: Colors.white),
                child: body(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder(
        builder: (CartController controller) {
          if (cartController.cartItems.isEmpty) {
            return const SizedBox();
          }
          return Container(
            margin: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Get.dialog(AlertDialog(
                  title: const Text("Place Order"),
                  content: const Text("Place order successfully"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          cartController.clearCart();
                          Get.back();
                          Get.back();
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                ));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(50)),
                child: const Center(
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.circular(5.0)),
          child: Center(
            child: Text(
              "${cartController.count} Dishes - ${cartController.itemCount} Items",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        ...cartController.cartItems.values.map(
          (dish) => Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVegIcon(dish.dishType),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.dishName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "INR ${(dish.dishPrice * sapPrice).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${dish.dishCalories} Calories",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        dish.dishDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder(
                        builder: (CartController controller) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      if (dish.count != 0) {
                                        appController.addAppEvent(
                                            AppEvent.cartUpdate(
                                                categoryDish: dish,
                                                count: dish.count - 1));
                                      }
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: Text(
                                    dish.count.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      appController.addAppEvent(
                                          AppEvent.cartUpdate(
                                              categoryDish: dish,
                                              count: dish.count + 1));
                                    },
                                    child: const Icon(Icons.add,
                                        color: Colors.white)),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      dish.addonCat!.isNotEmpty
                          ? const Text(
                              "Customization Available",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3.0),
                      image:
                          DecorationImage(image: NetworkImage(dish.dishImage))),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Total amount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: Text(
                "INR ${cartController.totalPrice.toStringAsFixed(2)}",
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget getVegIcon(int num) {
    return Image.asset(
      num == 2 ? AppIcon.veg : AppIcon.nonVeg,
      height: 22,
      width: 22,
    );
  }
}
