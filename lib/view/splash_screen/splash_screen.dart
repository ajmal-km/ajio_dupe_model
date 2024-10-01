import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:ajio_dupe_model/utils/image_constants.dart';
import 'package:ajio_dupe_model/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: _buildSplashLogoSection(),
    );
  }

  Widget _buildSplashLogoSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            fit: BoxFit.contain,
            ImageConstants.LOGO,
          ),
          SizedBox(height: 40),
          Text(
            "SHOPKART",
            style: TextStyle(
              color: ColorConstants.blue,
              fontSize: 33,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          )
        ],
      ),
    );
  }
}
