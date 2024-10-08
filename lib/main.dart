import 'package:ajio_dupe_model/controller/cart_screen_controller.dart';
import 'package:ajio_dupe_model/controller/home_screen_controller.dart';
import 'package:ajio_dupe_model/controller/product_screen_controller.dart';
import 'package:ajio_dupe_model/model/cart_model.dart';
import 'package:ajio_dupe_model/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox"); // Hive step 1
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
