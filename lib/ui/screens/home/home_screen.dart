import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewtask/core/const/app_icon.dart';
import 'package:interviewtask/core/const/app_settings.dart';
import 'package:interviewtask/ui/app_controller.dart';
import 'package:interviewtask/ui/screens/auth/auth_screen.dart';
import 'package:interviewtask/ui/screens/home/controller/cart_controller.dart';
import 'package:interviewtask/ui/screens/home/controller/home_controller.dart';
import 'package:interviewtask/ui/screens/home/model/items_model.dart';
import 'package:interviewtask/ui/screens/home/widgets/cart_screen.dart';
import 'package:interviewtask/ui/shared/app_event/app_event.dart';

class HomeScreen extends StatefulWidget {
  static GlobalKey<ScaffoldState> baseKey = GlobalKey<ScaffoldState>();

  static const String routeName = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Scaffold(
          key: HomeScreen.baseKey,
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  HomeScreen.baseKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              actions: [
                GetBuilder(
                  builder: (CartController controller) {
                    return IconButton(
                        onPressed: () {
                          Get.toNamed(CartScreen.routeName);
                        },
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(
                              Icons.add_shopping_cart,
                              size: 28,
                              color: Colors.black,
                            ),
                            controller.count == 0
                                ? const SizedBox()
                                : Positioned(
                                    top: -5,
                                    right: -5,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                      child: Center(
                                        child: Text(
                                          controller.count.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ));
                  },
                )
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(controller.items != null ? 40 : 0.0),
                child: GetBuilder(
                  builder: (HomeController controller) {
                    if (controller.items != null) {
                      return TabBar(
                          controller: tabController,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.red.shade600,
                          indicatorColor: Colors.red.shade600,
                          isScrollable: true,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w500),
                          tabs: controller.categories
                              .map((e) => Tab(
                                    text: e.menuCategory,
                                  ))
                              .toList());
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )),
          body: GetBuilder(
            builder: (HomeController controller) {
              if (controller.isLoading || controller.items == null) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.uiFailure != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.error,
                      size: 100,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Some error occurred",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline2?.color,
                        //   color: AppTheme.pureWhiteColor,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        controller.fetchItems();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                );
              }
              return TabBarView(
                  controller: tabController,
                  children: controller.categories
                      .asMap()
                      .map((key, value) => MapEntry(key, body(value)))
                      .values
                      .toList());
            },
          ),
          drawer: appDrawer(),
        );
      },
    );
  }

  Drawer appDrawer() {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 23,
                  foregroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL ?? "",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(FirebaseAuth.instance.currentUser!.phoneNumber ??
                    FirebaseAuth.instance.currentUser!.displayName ??
                    "Unknow")
              ],
            ),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(AuthScreen.routeName);
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
          )
        ],
      ),
    );
  }

  Widget body(TableMenuList tableMenuList) {
    return ListView(
      children: [
        ...tableMenuList.categoryDishes
            .asMap()
            .map((index, dish) => MapEntry(
                index,
                Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  "INR ${(dish.dishPrice * sapPrice).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Text(
                                  "${dish.dishCalories} Calories",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
                              id: "quantityUpdate",
                              builder: (HomeController controller) {
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
                                              dish.count--;
                                              appController.addAppEvent(
                                                  AppEvent.cartUpdate(
                                                      categoryDish: dish));
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            dish.count++;
                                            appController.addAppEvent(
                                                AppEvent.cartUpdate(
                                                    categoryDish: dish));
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
                            image: DecorationImage(
                                image: NetworkImage(dish.dishImage))),
                      )
                    ],
                  ),
                )))
            .values
            .toList()
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
