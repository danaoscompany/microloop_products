import 'package:flutter/material.dart';
import 'package:microloop_product/global.dart';
import "package:collection/collection.dart";

class Cart extends StatefulWidget {
  const Cart(this.context, this.string, this.addedProducts);
  final context;
  final string;
  final addedProducts;

  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> {
  var totalPrices = 0;
  var deliveryFee = 0;
  var total = 0;
  var addedProducts = [];
  var groupedProducts = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var _addedProducts = widget.addedProducts;
      _addedProducts.sort((product1, product2) {
        return product1["title"].toString().trim().compareTo(product2["title"].toString().trim());
      });
      for (var product in _addedProducts) {
        if (isProductAlreadyGrouped(product)) {
          var qty = int.parse(product["qty"].toString().trim());
          qty++;
          product["qty"] = qty;
        } else {
          product["qty"] = 1;
          setState(() {
            groupedProducts.add(product);
          });
        }
      }
      setState(() {
        addedProducts = _addedProducts;
      });
    });
  }

  isProductAlreadyGrouped(product) {
    for (var p in groupedProducts) {
      if (p["id"].toString().trim() == product["id"].toString().trim()) {
        return true;
      }
    }
    return false;
  }

  addProduct(product) {
    setState(() {
      addedProducts.add(product);
      for (var p in groupedProducts) {
        if (p["id"] == product["id"]) {
          setState(() {
            var qty = int.parse(p["qty"].toString().trim());
            qty++;
            p["qty"] = qty;
          });
          return;
        }
      }
    });
  }

  removeProduct(product) {
    for (var p in addedProducts) {
      if (p["id"] == product["id"]) {
        setState(() {
          addedProducts.remove(p);
        });
        break;
      }
    }
    for (var p in groupedProducts) {
      if (p["id"] == product["id"]) {
        setState(() {
          var qty = int.parse(p["qty"].toString().trim());
          if (qty > 0) {
            qty--;
          }
          p["qty"] = qty;
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = Global.getWidth(context);
    var height = Global.getHeight(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(width: width, child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 40, height: 40, child: Material(
                                child: InkWell(
                                    child: Center(child: Icon(Icons.arrow_back, color: Colors.black, size: 20)),
                                    onTap: () {
                                      Navigator.pop(context, {
                                        "products": addedProducts
                                      });
                                    }
                                )
                            )),
                            Text(widget.string.cart, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                            Container(width: 40, height: 40)
                          ]
                      ),
                      SingleChildScrollView(
                          child: Column(
                              children: [
                                ListView.builder(
                                    itemCount: groupedProducts.length,
                                    itemBuilder: (context, index) {
                                      var product = groupedProducts[index];
                                      return Container(
                                          child: Padding(
                                              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                              child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Image.network(product["thumbnail"].toString().trim(), width: 100, height: 100, fit: BoxFit.cover),
                                                    SizedBox(width: 10),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(product["title"].toString().trim(), style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                          Text("\$"+product["price"].toString().trim(), style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                                          Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Row(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(width: 24, height: 24, decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(12),
                                                                        border: Border.all(color: Colors.black, width: 1)
                                                                    ), child: GestureDetector(
                                                                        behavior: HitTestBehavior.translucent,
                                                                        child: Center(child: Icon(Icons.remove, color: Colors.black, size: 20)),
                                                                        onTap: () {
                                                                          removeProduct(product);
                                                                        }
                                                                    )),
                                                                    SizedBox(width: 10),
                                                                    Text(product["qty"].toString().trim(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                                                                    SizedBox(width: 10),
                                                                    Container(width: 24, height: 24, decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(12),
                                                                        border: Border.all(color: Colors.black, width: 1)
                                                                    ), child: GestureDetector(
                                                                        behavior: HitTestBehavior.translucent,
                                                                        child: Center(child: Icon(Icons.add, color: Colors.black, size: 20)),
                                                                        onTap: () {
                                                                          addProduct(product);
                                                                        }
                                                                    ))
                                                                  ]
                                                              )
                                                          )
                                                        ]
                                                    )
                                                  ]
                                              )
                                          )
                                      );
                                    },
                                    shrinkWrap: true
                                ),
                                SizedBox(height: 10),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.string.text3, style: TextStyle(color: Color(0x7f888888), fontSize: 14)),
                                          Text("\$ "+Global.formatMoney(totalPrices), style: TextStyle(color: Color(0x7f888888), fontSize: 14))
                                        ]
                                    )
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.string.text4, style: TextStyle(color: Color(0x7f888888), fontSize: 14)),
                                          Text("\$ 10", style: TextStyle(color: Color(0x7f888888), fontSize: 14))
                                        ]
                                    )),
                                SizedBox(height: 5),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.string.text5, style: TextStyle(color: Color(0x7f888888), fontSize: 14)),
                                          Text("\$ "+Global.formatMoney(totalPrices), style: TextStyle(color: Color(0x7f888888), fontSize: 14))
                                        ]
                                    ))
                              ]
                          )
                      )
                    ]
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                            width: 200, height: 50, decoration: BoxDecoration(
                            color: Color(0xffff8c00),
                            borderRadius: BorderRadius.circular(30)
                        ), child: Center(
                            child: Text(widget.string.checkout, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
                        )),
                        onTap: () {}
                      )
                    )
                  )
                )
              ]
            ))
        )
    );
  }
}