import 'package:get/get.dart';
import 'package:interviewtask/ui/screens/auth/auth_screen.dart';
import 'package:interviewtask/ui/screens/auth/widget/otp_screen.dart';
import 'package:interviewtask/ui/screens/home/widgets/cart_screen.dart';

import '../../ui/screens/home/home_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  GetPage(name: AuthScreen.routeName, page: () => const AuthScreen()),
  GetPage(name: OTPScreen.routeName, page: () => const OTPScreen()),
  GetPage(name: CartScreen.routeName, page: () => const CartScreen()),
];
