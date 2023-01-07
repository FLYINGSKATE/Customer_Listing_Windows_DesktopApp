// Don't forget to make the changes mentioned in
// https://github.com/bitsdojo/bitsdojo_window#getting-started

import 'package:customer_listing_desktop_app/utils/CustomTheme.dart';
import 'package:customer_listing_desktop_app/utils/Router.dart';
import 'package:customer_listing_desktop_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Subscribo! Customer Listing & Management";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:CustomThemes.light,
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      initialRoute: 'HomeScreen',
      onGenerateRoute: ScreenRouter.generateRoute,

      /*home: Scaffold(
        body: WindowBorder(
          color: primaryColorOfApp,
          width: 1,
          child: Row(
            children: const [LeftSide(), RightSide()],
          ),
        ),
      ),*/
    );
  }
}

Color sidebarColor = primaryColorOfApp;

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: sidebarColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: Container())
              ],
            )));
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          )
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: Colors.white.withOpacity(0.7),
    mouseDown: Colors.white,
    iconMouseOver: primaryColorOfApp.withOpacity(0.7),
    iconMouseDown: primaryColorOfApp);

final closeButtonColors = WindowButtonColors(
    mouseOver: Colors.redAccent,
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Colors.white,
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        )
            : MaximizeWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}