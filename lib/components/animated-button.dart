import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    @required this.zoomOutAnimation,
    @required this.squeezeAnimation,
    @required this.animationController,
    @required this.buttonGrowColorAnimation,
    @required this.textColor,
    @required this.textButton,
    @required this.buttonColor,
  });
  final Color buttonColor;
  final String textButton;
  final Color textColor;
  final Animation zoomOutAnimation;
  final Animation squeezeAnimation;
  final Color buttonGrowColorAnimation;
  final AnimationController animationController;

  Future<Null> _playAnimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _playAnimation();
        },
        child: Hero(
          tag: "fade",
          child: Container(
              width: zoomOutAnimation.value == 70
                  ? squeezeAnimation.value
                  : zoomOutAnimation.value,
              height:
                  zoomOutAnimation.value == 70 ? 60.0 : zoomOutAnimation.value,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: zoomOutAnimation.value == 70
                    ? buttonColor
                    : buttonGrowColorAnimation,
                borderRadius: zoomOutAnimation.value < 400
                    ? new BorderRadius.all(const Radius.circular(30.0))
                    : new BorderRadius.all(const Radius.circular(0.0)),
              ),
              child: squeezeAnimation.value > 75
                  ? new Text(
                      textButton,
                      style: new TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    )
                  : zoomOutAnimation.value < 300
                      ? CircularProgressIndicator(
                          value: null,
                          strokeWidth: 1.0,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(textColor),
                        )
                      : null),
        ),
      ),
    );
  }
}
