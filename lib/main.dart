import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:interviewtask/core/bindings/app_binding.dart';
import 'package:interviewtask/core/utils/app_routes.dart';
import 'package:interviewtask/ui/app_controller.dart';
import 'package:interviewtask/ui/screens/auth/auth_screen.dart';
import 'package:interviewtask/ui/screens/home/home_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'core/data/network/api_client.dart';
import 'core/data/network/dio/dio_api_client.dart';
import 'core/data/repository/user_repo.dart';
import 'core/data/repository/user_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I.registerSingletonAsync<ApiClient>(
    () => DioApiClient.getInstance(),
  );
  GetIt.I.registerSingletonWithDependencies<UserRepo>(
    () => UserRepoImpl(),
    dependsOn: [
      ApiClient,
    ],
  );
  Get.put(AppController());

  await GetIt.I.allReady();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black54,
        overlayWidget: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.green,
          ),
        ),
        child: GetMaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
          title: 'Demo Task',
          initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          initialRoute: FirebaseAuth.instance.currentUser != null
              ? HomeScreen.routeName
              : AuthScreen.routeName,
          getPages: routes,
        ));
  }
}
