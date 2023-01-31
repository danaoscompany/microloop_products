import 'package:flutter/material.dart';
import 'package:microloop_product/global.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(this.context, this.string, this.category, this.product);
  final context;
  final string;
  final category;
  final product;

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {

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
            body: Container(width: width, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: [
                              Material(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context, {
                                          "product": widget.product
                                        });
                                      },
                                      child: Container(width: 50, height: 50, child: Center(
                                          child: Icon(Icons.arrow_back, color: Colors.black, size: 20)
                                      ))
                                  )
                              ),
                              SizedBox(width: 10),
                              Text(Global.formatCategory(widget.category), style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))
                            ]
                        ),
                        Container(width: 40, height: 40, child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Center(child: Icon(Icons.shopping_cart, color: Color(0xffff8c00), size: 30))
                        ))
                      ]
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: Card(
                                        child: Container(
                                            width: width-20-20,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(widget.product["thumbnail"].toString().trim(), width: width-20-20, height: 250, fit: BoxFit.cover))
                                        )
                                    )
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tomato", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                      Text("\$ 25/kg", style: TextStyle(color: Color(0x4f888888), fontSize: 15))
                                    ]
                                  )
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Card(
                                    color: Color(0xfffafafc),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(width: 60, height: 30, child: Material(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: new InkWell(
                                                        borderRadius: BorderRadius.circular(20),
                                                        onTap: () {
                                                          var count = int.parse(widget.product["count"].toString().trim());
                                                          if (count > 0) {
                                                            count--;
                                                          }
                                                          setState(() {
                                                            widget.product["count"] = count;
                                                          });
                                                        },
                                                        child: Container(height: 30, decoration: BoxDecoration(
                                                            color: Color(0xfffae8c8),
                                                            borderRadius: BorderRadius.circular(20)
                                                        ), child: Center(child: Icon(Icons.remove, color: Color(0xffff8c00), size: 20)))
                                                    ),
                                                    color: Colors.transparent,
                                                  )),
                                                  SizedBox(width: 10),
                                                  Text(widget.product["count"].toString().trim(), style: TextStyle(
                                                      color: Color(0xff000000),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  )),
                                                  SizedBox(width: 10),
                                                  Container(width: 60, height: 30, child: Material(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: new InkWell(
                                                        borderRadius: BorderRadius.circular(20),
                                                        onTap: () {
                                                          var count = int.parse(widget.product["count"].toString().trim());
                                                          count++;
                                                          setState(() {
                                                            widget.product["count"] = count;
                                                          });
                                                        },
                                                        child: Container(height: 30, decoration: BoxDecoration(
                                                            color: Color(0xfffae8c8),
                                                            borderRadius: BorderRadius.circular(20)
                                                        ), child: Center(child: Icon(Icons.add, color: Color(0xffff8c00), size: 20)))
                                                    ),
                                                    color: Colors.transparent,
                                                  ))
                                                ]
                                            ),
                                            Material(
                                              child: new InkWell(
                                                  borderRadius: BorderRadius.circular(30),
                                                  onTap: () {
                                                    var count = int.parse(widget.product["count"].toString().trim());
                                                    count++;
                                                    setState(() {
                                                      widget.product["count"] = count;
                                                    });
                                                  },
                                                  child: Container(
                                                      width: 100,
                                                      height: 30, decoration: BoxDecoration(
                                                      color: Color(0xffff8c00),
                                                      borderRadius: BorderRadius.circular(30)
                                                  ), child: Padding(
                                                      padding: EdgeInsets.only(left: 20, right: 20),
                                                      child: Center(child: Text(widget.string.add, style: TextStyle(color: Colors.white, fontSize: 14)))
                                                  ))
                                              ),
                                              color: Colors.transparent,
                                            )
                                          ]
                                      )
                                    )
                                  )
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 10),
                                  child: Text("Tomato", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 10),
                                  child: Text(widget.product["description"].toString().trim(), style: TextStyle(color: Color(0xff888888), fontSize: 14)),
                                )
                              ]
                          )
                      )
                  )
                ]
            ))
        )
    );
  }
}