import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/pages/article_page.dart';
import 'package:toko_app/pages/getstarted_page.dart';
import 'package:toko_app/pages/login_page.dart';
import 'package:toko_app/pages/main_page.dart';
import 'package:toko_app/pages/product_page.dart';
import 'package:toko_app/pages/sign_up_page.dart';
import 'package:toko_app/pages/splash_page.dart';
import 'package:toko_app/providers/cart_provider.dart';
import 'package:toko_app/providers/transaction_provider.dart';
import 'package:toko_app/providers/userApp_provider.dart';
import 'package:toko_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => UserAppProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {
          '/splash': (context) => const SplashPage(),
          '/mainPage': (context) => const MainPage(),
          '/getstarted': (context) => const GetStartedPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/artikel': (context) => const ArticlePage(),
        },
        home: const SplashPage(),
      ),
    );
  }
}
