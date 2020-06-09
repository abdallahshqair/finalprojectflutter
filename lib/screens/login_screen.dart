import 'package:finalprojectflutter/provider/adminMode.dart';
import 'package:finalprojectflutter/screens/admin/adminHome.dart';
import 'package:finalprojectflutter/screens/signup_screen.dart';
import 'package:finalprojectflutter/screens/user/homePage.dart';
import 'package:finalprojectflutter/widgets/custom_textfield.dart';
import 'package:finalprojectflutter/widgets/cutsom_logo.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectflutter/constants.dart';
import 'package:finalprojectflutter/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:finalprojectflutter/provider/modelHud.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, password;
  final _auth = Auth();
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final adminPassword = 'admin';
  final adminemail='admin@gmail.com';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              CustomLogo(),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40 ),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _validate(context);
                    },
                    color: Colors.blue,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await _auth.signIn(_email.trim(), password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          if(_email.trim()==adminemail &&password.trim()==adminPassword){
            Navigator.pushNamed(context, AdminHome.id);
          }else {
            await _auth.signIn(_email.trim(), password.trim());
            Navigator.pushNamed(context, HomePage.id);
          }
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);
  }
}
