import 'package:afazeres/facade/facade.dart';
import 'package:afazeres/pages/home_page.dart';
import 'package:afazeres/utils/navigator.dart';
import 'package:afazeres/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  _goToHome() async {
    await new Facade().setAlreadyViewIntroPage();

    push(context, HomePage(), replace: true);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    new Facade().getIntroPageShown().then((data) { print(data); });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: _getScreen(),
      ),
    );
  }

  _getScreen() {
    const pageDecoration = PageDecoration(pageColor: Colors.white);

    return IntroductionScreen(
      pages: [
        PageViewModel(
          decoration: pageDecoration,
          title: "Socorro!",
          body:
              "Organizar as tarefas do dia a dia realmente é uma tarefa (outra) que por mais que pareça simples, é difícil pra muita gente. Então, eu fui feito pra te ajudar nisso ^-^!",
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/atarefado_logo.png', height: 240),
          ),
        ),
        PageViewModel(
          decoration: pageDecoration,
          title: 'Foco!',
          body: "Adicione todas as suas atividades para agora ou para depois!",
          image: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/todo_example.jpeg',
              ),
            ),
          ),
        ),
        PageViewModel(
          decoration: pageDecoration,
          title: 'Atualize tudo!',
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/not_realized_todo.png',
                  height: 124,
                  fit: BoxFit.fill,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 24,
                ),
                Image.asset(
                  'assets/images/realized_todo.png',
                  height: 124,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          bodyWidget: Column(
            children: [
              CustomText(
                text:
                    'Mantenha-se persistente atualizando a condição de suas atividades..',
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
      onDone: _goToHome,
      done: CustomText(
        color: Colors.cyan,
        text: 'Começar!',
        isBold: true,
      ),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.cyan,
        activeSize: Size(22, 10),
        size: Size(10, 7),
        color: Colors.grey,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
