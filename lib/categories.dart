import 'package:flutter/material.dart';
import 'package:microloop_product/global.dart';

class Categories extends StatefulWidget {
  const Categories(this.context, this.string);
  final context;
  final string;

  @override
  State<Categories> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  var categories = [];

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
            body: Container(width: width, child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var category = categories[index];
                return Container(
                  width: width,
                  height: 60,
                  child: Material(
                    child: InkWell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text(category, style: TextStyle(color: Color(0x7f444444), fontSize: 15))
                          )
                      ),
                      onTap: () {

                      }
                    )
                  )
                );
              }
            ))
        )
    );
  }
}