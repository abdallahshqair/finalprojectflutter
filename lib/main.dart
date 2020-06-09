import 'package:finalprojectflutter/models/product.dart';
import 'package:finalprojectflutter/provider/adminMode.dart';
import 'package:finalprojectflutter/provider/cartItem.dart';
import 'package:finalprojectflutter/provider/modelHud.dart';
import 'package:finalprojectflutter/screens/admin/OrdersScreen.dart';
import 'package:finalprojectflutter/screens/admin/addProduct.dart';
import 'package:finalprojectflutter/screens/admin/adminHome.dart';
import 'package:finalprojectflutter/screens/admin/editProduct.dart';
import 'package:finalprojectflutter/screens/admin/manageProduct.dart';
import 'package:finalprojectflutter/screens/login_screen.dart';
import 'package:finalprojectflutter/screens/signup_screen.dart';
import 'package:finalprojectflutter/screens/user/CartScreen.dart';
import 'package:finalprojectflutter/screens/user/homePage.dart';
import 'package:finalprojectflutter/screens/user/productInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          OrdersScreen.id: (context) => OrdersScreen(),
          CartScreen.id: (context) => CartScreen(),
          ProductInfo.id: (context) => ProductInfo(),
          EditProduct.id: (context) => EditProduct(),
          ManageProducts.id: (context) => ManageProducts(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
        },
      ),
    );
  }
}
