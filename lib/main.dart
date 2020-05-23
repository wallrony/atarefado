import 'package:afazeres/pages/home_page.dart';
import 'package:afazeres/providers/todo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TODOListProvider())],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black12,
          splashColor: Colors.white.withOpacity(.88),
          accentColor: Colors.cyan,
          primarySwatch: Colors.cyan,
          primaryColor: Colors.white,
          fontFamily: 'Raleway',
          cursorColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
