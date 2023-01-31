import 'package:flutter/material.dart';
import 'package:microloop_product/global.dart';
import 'package:microloop_product/home.dart';

class Splash extends StatefulWidget {
  const Splash(this.context, this.string);
  final context;
  final string;

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Global.replaceScreen(context, Home(widget.context, widget.string));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = Global.getWidth(context);
    var height = Global.getHeight(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(width: width, child: Center(
          	child: Image.asset("assets/images/logo01.png", width: 300, height: 100)
          ))
      )
    );
  }
}
