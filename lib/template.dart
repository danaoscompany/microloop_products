import 'package:flutter/material.dart';
import 'package:microloop_product/global.dart';

class Template extends StatefulWidget {
  const Template(this.context, this.string);
  final context;
  final string;

  @override
  State<Template> createState() => TemplateState();
}

class TemplateState extends State<Template> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = Global.getWidth(context);
    var height = Global.getHeight(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(width: width, child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  ]
              )
          ))
      )
    );
  }
}