import 'package:afazeres/facade/facade.dart';
import 'package:afazeres/pages/home_page.dart';
import 'package:afazeres/pages/introduction_page.dart';
import 'package:afazeres/utils/navigator.dart';
import 'package:afazeres/widgets/custom_text.dart';
import 'package:afazeres/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {

  _getIntroPageAlreadyShow() async {
    bool result = await new Facade().getIntroPageShown();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    Future.delayed(const Duration(seconds: 3), () async {
      bool result = await _getIntroPageAlreadyShow() ?? false;

      var page;

      if(result) {
        page = HomePage();
      }
      else {
        page = IntroductionPage();
      }

      push(context, page, replace: true);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash_atarefado_logo',
              child: Image.asset(
                'assets/images/atarefado_logo.png',
                height: 196,
              ),
            ),
            CustomText(
              text: 'Atarefado',
              align: TextAlign.center,
              isBold: true,
              color: Colors.cyan,
              fontSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
