import 'package:flutter_animated_login_screen/components/animated-button.dart';
import 'package:flutter_animated_login_screen/components/input-field-area.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _squeezeAnimation, _zoomOutAnimation;

  @override
  void initState() {
    super.initState();
    animationInitState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonGrowColorAnimation = const Color.fromRGBO(210, 85, 81, 1);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.4,
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
            height: 1000,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _zoomOutAnimation.value > 400
                ? Container()
                : Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                      ),
                      Image.asset("assets/logo.png"),
                      SizedBox(
                        height: 50,
                      ),
                      InputFieldArea(
                          hint: "Username", obscure: false, icon: Icons.person),
                      InputFieldArea(
                          hint: "Password",
                          obscure: true,
                          icon: Icons.lock_open),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
            AnimatedButton(
                animationController: _animationController,
                zoomOutAnimation: _zoomOutAnimation,
                squeezeAnimation: _squeezeAnimation,
                buttonGrowColorAnimation: buttonGrowColorAnimation,
                buttonColor: const Color.fromRGBO(210, 85, 81, 1),
                textButton: 'Sign in',
                textColor: Colors.white),
            _zoomOutAnimation.value > 400
                ? Container()
                : Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
          ],
        )
      ],
    );
  }

  void animationInitState() {
    super.initState();
    _animationController = new AnimationController(
        duration: new Duration(seconds: 3), vsync: this);
    _squeezeAnimation = new Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(new CurvedAnimation(
        parent: _animationController, curve: new Interval(0.0, 0.250)));
    _squeezeAnimation.addListener(() {
      setState(() {});
      print(_squeezeAnimation.value);
    });
    _zoomOutAnimation = new Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(
        0.550,
        0.900,
        curve: Curves.bounceOut,
      ),
    ));
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.dispose();
        print("Next Screen doesn't exist");
      }
      ;
    });
  }
}
