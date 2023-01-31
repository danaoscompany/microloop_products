import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:microloop_product/cart.dart';
import 'package:microloop_product/constants.dart';
import 'package:microloop_product/global.dart';
import 'package:microloop_product/product_details.dart';

class Products extends StatefulWidget {
  Products(this.context, this.string);
  final context;
  final string;
  var state = ProductsState();

  @override
  State<Products> createState() => state;

  ProductsState getState() {
    return state;
  }
}

class ProductsState extends State<Products> {
  List<dynamic> products = [];
  var start = 0;
  var length = 10;
  var mainLoading = true;
  var loading = false;
  var controller = ScrollController();
  var categories = [];
  var selectedCategory = null;
  var addedProducts = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.addListener(() async {
        if (controller.position.atEdge) {
          bool isTop = controller.position.pixels == 0;
          if (!isTop) {
            setState(() {
              loading = true;
            });
            await getProducts();
            setState(() {
              loading = false;
            });
          }
        }
      });
      setState(() {
        mainLoading = true;
      });
      await getCategories();
      setState(() {
        if (categories.length > 0) {
          selectedCategory = categories[0];
        }
      });
      await getProducts();
      setState(() {
        mainLoading = false;
      });
      /*var products = jsonDecode("{\"products\":[{\"id\":1,\"title\":\"iPhone 9\",\"description\":\"An apple mobile which is nothing like apple\",\"price\":549,\"discountPercentage\":12.96,\"rating\":4.69,\"stock\":94,\"brand\":\"Apple\",\"category\":\"smartphones\",\"thumbnail\":\"https://i.dummyjson.com/data/products/1/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/1/1.jpg\",\"https://i.dummyjson.com/data/products/1/2.jpg\",\"https://i.dummyjson.com/data/products/1/3.jpg\",\"https://i.dummyjson.com/data/products/1/4.jpg\",\"https://i.dummyjson.com/data/products/1/thumbnail.jpg\"]},{\"id\":2,\"title\":\"iPhone X\",\"description\":\"SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...\",\"price\":899,\"discountPercentage\":17.94,\"rating\":4.44,\"stock\":34,\"brand\":\"Apple\",\"category\":\"smartphones\",\"thumbnail\":\"https://i.dummyjson.com/data/products/2/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/2/1.jpg\",\"https://i.dummyjson.com/data/products/2/2.jpg\",\"https://i.dummyjson.com/data/products/2/3.jpg\",\"https://i.dummyjson.com/data/products/2/thumbnail.jpg\"]},{\"id\":3,\"title\":\"Samsung Universe 9\",\"description\":\"Samsung's new variant which goes beyond Galaxy to the Universe\",\"price\":1249,\"discountPercentage\":15.46,\"rating\":4.09,\"stock\":36,\"brand\":\"Samsung\",\"category\":\"smartphones\",\"thumbnail\":\"https://i.dummyjson.com/data/products/3/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/3/1.jpg\"]},{\"id\":4,\"title\":\"OPPOF19\",\"description\":\"OPPO F19 is officially announced on April 2021.\",\"price\":280,\"discountPercentage\":17.91,\"rating\":4.3,\"stock\":123,\"brand\":\"OPPO\",\"category\":\"smartphones\",\"thumbnail\":\"https://i.dummyjson.com/data/products/4/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/4/1.jpg\",\"https://i.dummyjson.com/data/products/4/2.jpg\",\"https://i.dummyjson.com/data/products/4/3.jpg\",\"https://i.dummyjson.com/data/products/4/4.jpg\",\"https://i.dummyjson.com/data/products/4/thumbnail.jpg\"]},{\"id\":5,\"title\":\"Huawei P30\",\"description\":\"Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK.\",\"price\":499,\"discountPercentage\":10.58,\"rating\":4.09,\"stock\":32,\"brand\":\"Huawei\",\"category\":\"smartphones\",\"thumbnail\":\"https://i.dummyjson.com/data/products/5/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/5/1.jpg\",\"https://i.dummyjson.com/data/products/5/2.jpg\",\"https://i.dummyjson.com/data/products/5/3.jpg\"]},{\"id\":6,\"title\":\"MacBook Pro\",\"description\":\"MacBook Pro 2021 with mini-LED display may launch between September, November\",\"price\":1749,\"discountPercentage\":11.02,\"rating\":4.57,\"stock\":83,\"brand\":\"Apple\",\"category\":\"laptops\",\"thumbnail\":\"https://i.dummyjson.com/data/products/6/thumbnail.png\",\"images\":[\"https://i.dummyjson.com/data/products/6/1.png\",\"https://i.dummyjson.com/data/products/6/2.jpg\",\"https://i.dummyjson.com/data/products/6/3.png\",\"https://i.dummyjson.com/data/products/6/4.jpg\"]},{\"id\":7,\"title\":\"Samsung Galaxy Book\",\"description\":\"Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched\",\"price\":1499,\"discountPercentage\":4.15,\"rating\":4.25,\"stock\":50,\"brand\":\"Samsung\",\"category\":\"laptops\",\"thumbnail\":\"https://i.dummyjson.com/data/products/7/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/7/1.jpg\",\"https://i.dummyjson.com/data/products/7/2.jpg\",\"https://i.dummyjson.com/data/products/7/3.jpg\",\"https://i.dummyjson.com/data/products/7/thumbnail.jpg\"]},{\"id\":8,\"title\":\"Microsoft Surface Laptop 4\",\"description\":\"Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen.\",\"price\":1499,\"discountPercentage\":10.23,\"rating\":4.43,\"stock\":68,\"brand\":\"Microsoft Surface\",\"category\":\"laptops\",\"thumbnail\":\"https://i.dummyjson.com/data/products/8/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/8/1.jpg\",\"https://i.dummyjson.com/data/products/8/2.jpg\",\"https://i.dummyjson.com/data/products/8/3.jpg\",\"https://i.dummyjson.com/data/products/8/4.jpg\",\"https://i.dummyjson.com/data/products/8/thumbnail.jpg\"]},{\"id\":9,\"title\":\"Infinix INBOOK\",\"description\":\"Infinix Inbook X1 Ci3 10th 8GB 256GB 14 Win10 Grey – 1 Year Warranty\",\"price\":1099,\"discountPercentage\":11.83,\"rating\":4.54,\"stock\":96,\"brand\":\"Infinix\",\"category\":\"laptops\",\"thumbnail\":\"https://i.dummyjson.com/data/products/9/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/9/1.jpg\",\"https://i.dummyjson.com/data/products/9/2.png\",\"https://i.dummyjson.com/data/products/9/3.png\",\"https://i.dummyjson.com/data/products/9/4.jpg\",\"https://i.dummyjson.com/data/products/9/thumbnail.jpg\"]},{\"id\":10,\"title\":\"HP Pavilion 15-DK1056WM\",\"description\":\"HP Pavilion 15-DK1056WM Gaming Laptop 10th Gen Core i5, 8GB, 256GB SSD, GTX 1650 4GB, Windows 10\",\"price\":1099,\"discountPercentage\":6.18,\"rating\":4.43,\"stock\":89,\"brand\":\"HP Pavilion\",\"category\":\"laptops\",\"thumbnail\":\"https://i.dummyjson.com/data/products/10/thumbnail.jpeg\",\"images\":[\"https://i.dummyjson.com/data/products/10/1.jpg\",\"https://i.dummyjson.com/data/products/10/2.jpg\",\"https://i.dummyjson.com/data/products/10/3.jpg\",\"https://i.dummyjson.com/data/products/10/thumbnail.jpeg\"]},{\"id\":11,\"title\":\"perfume Oil\",\"description\":\"Mega Discount, Impression of Acqua Di Gio by GiorgioArmani concentrated attar perfume Oil\",\"price\":13,\"discountPercentage\":8.4,\"rating\":4.26,\"stock\":65,\"brand\":\"Impression of Acqua Di Gio\",\"category\":\"fragrances\",\"thumbnail\":\"https://i.dummyjson.com/data/products/11/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/11/1.jpg\",\"https://i.dummyjson.com/data/products/11/2.jpg\",\"https://i.dummyjson.com/data/products/11/3.jpg\",\"https://i.dummyjson.com/data/products/11/thumbnail.jpg\"]},{\"id\":12,\"title\":\"Brown Perfume\",\"description\":\"Royal_Mirage Sport Brown Perfume for Men & Women - 120ml\",\"price\":40,\"discountPercentage\":15.66,\"rating\":4,\"stock\":52,\"brand\":\"Royal_Mirage\",\"category\":\"fragrances\",\"thumbnail\":\"https://i.dummyjson.com/data/products/12/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/12/1.jpg\",\"https://i.dummyjson.com/data/products/12/2.jpg\",\"https://i.dummyjson.com/data/products/12/3.png\",\"https://i.dummyjson.com/data/products/12/4.jpg\",\"https://i.dummyjson.com/data/products/12/thumbnail.jpg\"]},{\"id\":13,\"title\":\"Fog Scent Xpressio Perfume\",\"description\":\"Product details of Best Fog Scent Xpressio Perfume 100ml For Men cool long lasting perfumes for Men\",\"price\":13,\"discountPercentage\":8.14,\"rating\":4.59,\"stock\":61,\"brand\":\"Fog Scent Xpressio\",\"category\":\"fragrances\",\"thumbnail\":\"https://i.dummyjson.com/data/products/13/thumbnail.webp\",\"images\":[\"https://i.dummyjson.com/data/products/13/1.jpg\",\"https://i.dummyjson.com/data/products/13/2.png\",\"https://i.dummyjson.com/data/products/13/3.jpg\",\"https://i.dummyjson.com/data/products/13/4.jpg\",\"https://i.dummyjson.com/data/products/13/thumbnail.webp\"]},{\"id\":14,\"title\":\"Non-Alcoholic Concentrated Perfume Oil\",\"description\":\"Original Al Munakh® by Mahal Al Musk | Our Impression of Climate | 6ml Non-Alcoholic Concentrated Perfume Oil\",\"price\":120,\"discountPercentage\":15.6,\"rating\":4.21,\"stock\":114,\"brand\":\"Al Munakh\",\"category\":\"fragrances\",\"thumbnail\":\"https://i.dummyjson.com/data/products/14/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/14/1.jpg\",\"https://i.dummyjson.com/data/products/14/2.jpg\",\"https://i.dummyjson.com/data/products/14/3.jpg\",\"https://i.dummyjson.com/data/products/14/thumbnail.jpg\"]},{\"id\":15,\"title\":\"Eau De Perfume Spray\",\"description\":\"Genuine  Al-Rehab spray perfume from UAE/Saudi Arabia/Yemen High Quality\",\"price\":30,\"discountPercentage\":10.99,\"rating\":4.7,\"stock\":105,\"brand\":\"Lord - Al-Rehab\",\"category\":\"fragrances\",\"thumbnail\":\"https://i.dummyjson.com/data/products/15/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/15/1.jpg\",\"https://i.dummyjson.com/data/products/15/2.jpg\",\"https://i.dummyjson.com/data/products/15/3.jpg\",\"https://i.dummyjson.com/data/products/15/4.jpg\",\"https://i.dummyjson.com/data/products/15/thumbnail.jpg\"]},{\"id\":16,\"title\":\"Hyaluronic Acid Serum\",\"description\":\"L'OrÃ©al Paris introduces Hyaluron Expert Replumping Serum formulated with 1.5% Hyaluronic Acid\",\"price\":19,\"discountPercentage\":13.31,\"rating\":4.83,\"stock\":110,\"brand\":\"L'Oreal Paris\",\"category\":\"skincare\",\"thumbnail\":\"https://i.dummyjson.com/data/products/16/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/16/1.png\",\"https://i.dummyjson.com/data/products/16/2.webp\",\"https://i.dummyjson.com/data/products/16/3.jpg\",\"https://i.dummyjson.com/data/products/16/4.jpg\",\"https://i.dummyjson.com/data/products/16/thumbnail.jpg\"]},{\"id\":17,\"title\":\"Tree Oil 30ml\",\"description\":\"Tea tree oil contains a number of compounds, including terpinen-4-ol, that have been shown to kill certain bacteria,\",\"price\":12,\"discountPercentage\":4.09,\"rating\":4.52,\"stock\":78,\"brand\":\"Hemani Tea\",\"category\":\"skincare\",\"thumbnail\":\"https://i.dummyjson.com/data/products/17/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/17/1.jpg\",\"https://i.dummyjson.com/data/products/17/2.jpg\",\"https://i.dummyjson.com/data/products/17/3.jpg\",\"https://i.dummyjson.com/data/products/17/thumbnail.jpg\"]},{\"id\":18,\"title\":\"Oil Free Moisturizer 100ml\",\"description\":\"Dermive Oil Free Moisturizer with SPF 20 is specifically formulated with ceramides, hyaluronic acid & sunscreen.\",\"price\":40,\"discountPercentage\":13.1,\"rating\":4.56,\"stock\":88,\"brand\":\"Dermive\",\"category\":\"skincare\",\"thumbnail\":\"https://i.dummyjson.com/data/products/18/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/18/1.jpg\",\"https://i.dummyjson.com/data/products/18/2.jpg\",\"https://i.dummyjson.com/data/products/18/3.jpg\",\"https://i.dummyjson.com/data/products/18/4.jpg\",\"https://i.dummyjson.com/data/products/18/thumbnail.jpg\"]},{\"id\":19,\"title\":\"Skin Beauty Serum.\",\"description\":\"Product name: rorec collagen hyaluronic acid white face serum riceNet weight: 15 m\",\"price\":46,\"discountPercentage\":10.68,\"rating\":4.42,\"stock\":54,\"brand\":\"ROREC White Rice\",\"category\":\"skincare\",\"thumbnail\":\"https://i.dummyjson.com/data/products/19/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/19/1.jpg\",\"https://i.dummyjson.com/data/products/19/2.jpg\",\"https://i.dummyjson.com/data/products/19/3.png\",\"https://i.dummyjson.com/data/products/19/thumbnail.jpg\"]},{\"id\":20,\"title\":\"Freckle Treatment Cream- 15gm\",\"description\":\"Fair & Clear is Pakistan's only pure Freckle cream which helpsfade Freckles, Darkspots and pigments. Mercury level is 0%, so there are no side effects.\",\"price\":70,\"discountPercentage\":16.99,\"rating\":4.06,\"stock\":140,\"brand\":\"Fair & Clear\",\"category\":\"skincare\",\"thumbnail\":\"https://i.dummyjson.com/data/products/20/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/20/1.jpg\",\"https://i.dummyjson.com/data/products/20/2.jpg\",\"https://i.dummyjson.com/data/products/20/3.jpg\",\"https://i.dummyjson.com/data/products/20/4.jpg\",\"https://i.dummyjson.com/data/products/20/thumbnail.jpg\"]},{\"id\":21,\"title\":\"- Daal Masoor 500 grams\",\"description\":\"Fine quality Branded Product Keep in a cool and dry place\",\"price\":20,\"discountPercentage\":4.81,\"rating\":4.44,\"stock\":133,\"brand\":\"Saaf & Khaas\",\"category\":\"groceries\",\"thumbnail\":\"https://i.dummyjson.com/data/products/21/thumbnail.png\",\"images\":[\"https://i.dummyjson.com/data/products/21/1.png\",\"https://i.dummyjson.com/data/products/21/2.jpg\",\"https://i.dummyjson.com/data/products/21/3.jpg\"]},{\"id\":22,\"title\":\"Elbow Macaroni - 400 gm\",\"description\":\"Product details of Bake Parlor Big Elbow Macaroni - 400 gm\",\"price\":14,\"discountPercentage\":15.58,\"rating\":4.57,\"stock\":146,\"brand\":\"Bake Parlor Big\",\"category\":\"groceries\",\"thumbnail\":\"https://i.dummyjson.com/data/products/22/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/22/1.jpg\",\"https://i.dummyjson.com/data/products/22/2.jpg\",\"https://i.dummyjson.com/data/products/22/3.jpg\"]},{\"id\":23,\"title\":\"Orange Essence Food Flavou\",\"description\":\"Specifications of Orange Essence Food Flavour For Cakes and Baking Food Item\",\"price\":14,\"discountPercentage\":8.04,\"rating\":4.85,\"stock\":26,\"brand\":\"Baking Food Items\",\"category\":\"groceries\",\"thumbnail\":\"https://i.dummyjson.com/data/products/23/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/23/1.jpg\",\"https://i.dummyjson.com/data/products/23/2.jpg\",\"https://i.dummyjson.com/data/products/23/3.jpg\",\"https://i.dummyjson.com/data/products/23/4.jpg\",\"https://i.dummyjson.com/data/products/23/thumbnail.jpg\"]},{\"id\":24,\"title\":\"cereals muesli fruit nuts\",\"description\":\"original fauji cereal muesli 250gm box pack original fauji cereals muesli fruit nuts flakes breakfast cereal break fast faujicereals cerels cerel foji fouji\",\"price\":46,\"discountPercentage\":16.8,\"rating\":4.94,\"stock\":113,\"brand\":\"fauji\",\"category\":\"groceries\",\"thumbnail\":\"https://i.dummyjson.com/data/products/24/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/24/1.jpg\",\"https://i.dummyjson.com/data/products/24/2.jpg\",\"https://i.dummyjson.com/data/products/24/3.jpg\",\"https://i.dummyjson.com/data/products/24/4.jpg\",\"https://i.dummyjson.com/data/products/24/thumbnail.jpg\"]},{\"id\":25,\"title\":\"Gulab Powder 50 Gram\",\"description\":\"Dry Rose Flower Powder Gulab Powder 50 Gram • Treats Wounds\",\"price\":70,\"discountPercentage\":13.58,\"rating\":4.87,\"stock\":47,\"brand\":\"Dry Rose\",\"category\":\"groceries\",\"thumbnail\":\"https://i.dummyjson.com/data/products/25/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/25/1.png\",\"https://i.dummyjson.com/data/products/25/2.jpg\",\"https://i.dummyjson.com/data/products/25/3.png\",\"https://i.dummyjson.com/data/products/25/4.jpg\",\"https://i.dummyjson.com/data/products/25/thumbnail.jpg\"]},{\"id\":26,\"title\":\"Plant Hanger For Home\",\"description\":\"Boho Decor Plant Hanger For Home Wall Decoration Macrame Wall Hanging Shelf\",\"price\":41,\"discountPercentage\":17.86,\"rating\":4.08,\"stock\":131,\"brand\":\"Boho Decor\",\"category\":\"home-decoration\",\"thumbnail\":\"https://i.dummyjson.com/data/products/26/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/26/1.jpg\",\"https://i.dummyjson.com/data/products/26/2.jpg\",\"https://i.dummyjson.com/data/products/26/3.jpg\",\"https://i.dummyjson.com/data/products/26/4.jpg\",\"https://i.dummyjson.com/data/products/26/5.jpg\",\"https://i.dummyjson.com/data/products/26/thumbnail.jpg\"]},{\"id\":27,\"title\":\"Flying Wooden Bird\",\"description\":\"Package Include 6 Birds with Adhesive Tape Shape: 3D Shaped Wooden Birds Material: Wooden MDF, Laminated 3.5mm\",\"price\":51,\"discountPercentage\":15.58,\"rating\":4.41,\"stock\":17,\"brand\":\"Flying Wooden\",\"category\":\"home-decoration\",\"thumbnail\":\"https://i.dummyjson.com/data/products/27/thumbnail.webp\",\"images\":[\"https://i.dummyjson.com/data/products/27/1.jpg\",\"https://i.dummyjson.com/data/products/27/2.jpg\",\"https://i.dummyjson.com/data/products/27/3.jpg\",\"https://i.dummyjson.com/data/products/27/4.jpg\",\"https://i.dummyjson.com/data/products/27/thumbnail.webp\"]},{\"id\":28,\"title\":\"3D Embellishment Art Lamp\",\"description\":\"3D led lamp sticker Wall sticker 3d wall art light on/off button  cell operated (included)\",\"price\":20,\"discountPercentage\":16.49,\"rating\":4.82,\"stock\":54,\"brand\":\"LED Lights\",\"category\":\"home-decoration\",\"thumbnail\":\"https://i.dummyjson.com/data/products/28/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/28/1.jpg\",\"https://i.dummyjson.com/data/products/28/2.jpg\",\"https://i.dummyjson.com/data/products/28/3.png\",\"https://i.dummyjson.com/data/products/28/4.jpg\",\"https://i.dummyjson.com/data/products/28/thumbnail.jpg\"]},{\"id\":29,\"title\":\"Handcraft Chinese style\",\"description\":\"Handcraft Chinese style art luxury palace hotel villa mansion home decor ceramic vase with brass fruit plate\",\"price\":60,\"discountPercentage\":15.34,\"rating\":4.44,\"stock\":7,\"brand\":\"luxury palace\",\"category\":\"home-decoration\",\"thumbnail\":\"https://i.dummyjson.com/data/products/29/thumbnail.webp\",\"images\":[\"https://i.dummyjson.com/data/products/29/1.jpg\",\"https://i.dummyjson.com/data/products/29/2.jpg\",\"https://i.dummyjson.com/data/products/29/3.webp\",\"https://i.dummyjson.com/data/products/29/4.webp\",\"https://i.dummyjson.com/data/products/29/thumbnail.webp\"]},{\"id\":30,\"title\":\"Key Holder\",\"description\":\"Attractive DesignMetallic materialFour key hooksReliable & DurablePremium Quality\",\"price\":30,\"discountPercentage\":2.92,\"rating\":4.92,\"stock\":54,\"brand\":\"Golden\",\"category\":\"home-decoration\",\"thumbnail\":\"https://i.dummyjson.com/data/products/30/thumbnail.jpg\",\"images\":[\"https://i.dummyjson.com/data/products/30/1.jpg\",\"https://i.dummyjson.com/data/products/30/2.jpg\",\"https://i.dummyjson.com/data/products/30/3.jpg\",\"https://i.dummyjson.com/data/products/30/thumbnail.jpg\"]}],\"total\":100,\"skip\":0,\"limit\":30}");
      setState(() {
        this.products = products["products"];
      });*/
    });
  }

  Future<void> getCategories() async {
    var response = await Global.httpGet(Constants.API_URL+"/products/categories");
    var categories = jsonDecode(response.body);
    setState(() {
      this.categories = categories;
    });
  }

  Future<void> getProducts() async {
    if (selectedCategory != null) {
      var response = await Global.httpGet(Constants.API_URL+"/products/category/"+selectedCategory+"?skip="+start.toString()+"&limit="+length.toString());
      var _products = jsonDecode(response.body)["products"];
      for (var product in _products) {
        product["count"] = 0;
        products.add(product);
      }
      setState(() {
        this.products = products;
        start += length;
      });
    }
  }

  Future<void> searchProducts(query) async {
    if (selectedCategory != null) {
      var response = await Global.httpGet(Constants.API_URL+"/products/search?q="+query);
      var _products = jsonDecode(response.body)["products"];
      for (var product in _products) {
        product["count"] = 0;
        products.add(product);
      }
      setState(() {
        this.products = products;
        start += length;
      });
    }
  }

  getProductQty(product) {
    var qty = 0;
    for (var p in addedProducts) {
      if (p["id"] == product["id"]) {
        qty++;
      }
    }
    return qty;
  }

  openCart() async {
    var result = await Global.navigate(context, Cart(context, widget.string, addedProducts));
    var products = result["products"];
    setState(() {
      addedProducts = products;
    });
  }

  void search(query) async {
    setState(() {
      start = 0;
      products = [];
    });
    setState(() {
      mainLoading = true;
    });
    if (query.trim() == "") {
      await getProducts();
    } else {
      await searchProducts(query.trim());
    }
    setState(() {
      mainLoading = false;
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
                      (() {
                        if (mainLoading) {
                          return Container(width: width, child: Center(
                              child: Lottie.asset('assets/animations/loading.json', width: 200, height: 200)
                          ));
                        } else {
                          return Stack(
                              children: [
                                (() {
                                  if (loading) {
                                    return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            width: width,
                                            height: 120,
                                            child: Padding(
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                child: Center(
                                                    child: Lottie.asset('assets/animations/loading.json', width: 150, height: 150)
                                                )
                                            )
                                        )
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }()),
                                Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20, right: 20),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(selectedCategory==null?"":Global.formatCategory(selectedCategory).replaceAll("-", ""), style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                                PopupMenuButton(
                                                    initialValue: selectedCategory,
                                                    onSelected: (category) async {
                                                      setState(() {
                                                        selectedCategory = category;
                                                        start = 0;
                                                        products = [];
                                                      });
                                                      setState(() {
                                                        mainLoading = true;
                                                      });
                                                      await getProducts();
                                                      setState(() {
                                                        mainLoading = false;
                                                      });
                                                    },
                                                    itemBuilder: (BuildContext context) => categories.map((category) {
                                                      return PopupMenuItem(
                                                        value: category,
                                                        child: Text(Global.formatCategory(category)),
                                                      );
                                                    }).toList(),
                                                    icon: Icon(Icons.filter_list, color: Color(0xff9590a4), size: 25)
                                                )
                                              ]
                                          )
                                      ),
                                      Expanded(
                                          child: GridView.count(
                                            controller: controller,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(bottom: 120),
                                            children: products.map((product) => Padding(
                                                padding: EdgeInsets.only(left: 5, right: 5),
                                                child: Material(
                                                  child: new InkWell(
                                                      onTap: () async {
                                                        var result = await Global.navigate(context, ProductDetails(context, widget.string, selectedCategory, product));
                                                        setState(() {
                                                          for (var i=0; i<products.length; i++) {
                                                            var product = products[i];
                                                            if (product["id"] == result["product"]["id"]) {
                                                              products[i] = product;
                                                              break;
                                                            }
                                                          }
                                                        });
                                                      },
                                                      child: new Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                          ),
                                                          elevation: 2,
                                                          child: Column(
                                                              children: [
                                                                Container(height: 171, child: Image.network(product["thumbnail"].toString().trim(), height: 171, fit: BoxFit.cover)),
                                                                Container(color: Color(0xfffafafc),
                                                                    child: Column(
                                                                        children: [
                                                                          SizedBox(height: 10),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(product["title"].toString().trim()),
                                                                                  Text("\$"+product["price"].toString().trim())
                                                                                ]
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 5),
                                                                          (() {
                                                                            var count = int.parse(product['count'].toString().trim());
                                                                            if (count <= 0) {
                                                                              return Material(
                                                                                child: new InkWell(
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                    onTap: () {
                                                                                      var count = int.parse(product["count"].toString().trim());
                                                                                      count++;
                                                                                      setState(() {
                                                                                        product["count"] = count;
                                                                                        addedProducts.add(product);
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
                                                                              );
                                                                            } else {
                                                                              return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Container(width: 60, height: 30, child: Material(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      child: new InkWell(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          onTap: () {
                                                                                            var count = int.parse(product["count"].toString().trim());
                                                                                            if (count > 0) {
                                                                                              count--;
                                                                                              setState(() {
                                                                                                for (var i=0; i<addedProducts.length; i++) {
                                                                                                  var addedProduct = addedProducts[i];
                                                                                                  if (int.parse(addedProduct["id"].toString().trim()) == int.parse(product["id"].toString().trim())) {
                                                                                                    addedProducts.remove(product);
                                                                                                    break;
                                                                                                  }
                                                                                                }
                                                                                              });
                                                                                            }
                                                                                            setState(() {
                                                                                              product["count"] = count;
                                                                                            });
                                                                                          },
                                                                                          child: Container(height: 30, decoration: BoxDecoration(
                                                                                              color: Color(0xfffae8c8),
                                                                                              borderRadius: BorderRadius.circular(20)
                                                                                          ), child: Center(child: Icon(Icons.remove, color: Color(0xffff8c00), size: 20)))
                                                                                      ),
                                                                                      color: Colors.transparent,
                                                                                    )),
                                                                                    Text(getProductQty(product).toString(), style: TextStyle(
                                                                                        color: Color(0xff000000),
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold
                                                                                    )),
                                                                                    Container(width: 60, height: 30, child: Material(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      child: new InkWell(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          onTap: () {
                                                                                            var count = int.parse(product["count"].toString().trim());
                                                                                            count++;
                                                                                            setState(() {
                                                                                              product["count"] = count;
                                                                                              addedProducts.add(product);
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
                                                                              );
                                                                            }
                                                                          }()),
                                                                          SizedBox(height: 10),
                                                                        ]
                                                                    ))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  color: Colors.transparent,
                                                )
                                            )).toList(),
                                          )
                                      )
                                    ]
                                )
                              ]
                          );
                        }
                      }())
                    ]
                )
            )
        )
    );
  }
}