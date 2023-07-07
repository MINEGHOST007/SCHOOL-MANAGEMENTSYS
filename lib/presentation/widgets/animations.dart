import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget{
  final double delay;
  final Widget child;
  final BuildContext context;

  const FadeAnimation(this.delay, this.child, this.context);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -130.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    // return ControlledAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]),
    //         child: child
    //     ),
    //   ),
    // );

    return TweenAnimationBuilder(
        tween: Tween<double>(begin:0,end:1),
      duration: const Duration(milliseconds: 750 ),
      builder: (context,double val,child){
        return Opacity(
          opacity: val,
          child: Padding(
          padding: EdgeInsets.only(top: val*50),
          child: child,
          ),
        );
    },
        child: child,



    );
  }
}



class FadeAnimation2 extends StatelessWidget{
  final double delay;
  final Widget child;
  final BuildContext context;

  const FadeAnimation2(this.delay, this.child, this.context);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -130.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    // return ControlledAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]),
    //         child: child
    //     ),
    //   ),
    // );

    return TweenAnimationBuilder(
      tween: Tween<double>(begin:0,end:1),
      duration: const Duration(milliseconds: 750 ),
      builder: (context,double val,child){
        final translateY = (1 - val) * 50;
        return Opacity(
          opacity: val,
          child: Transform.translate(
          offset: Offset(0, translateY),
          child: child,
          ),
        );
    },
        child: child,



    );
  }
}


class FadeAnimation3 extends StatelessWidget{
  final double delay;
  final Widget child;
  final BuildContext context;

  const FadeAnimation3(this.delay, this.child, this.context);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -130.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    // return ControlledAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]),
    //         child: child
    //     ),
    //   ),
    // );

    return TweenAnimationBuilder(
      tween: Tween<double>(begin:0,end:1),
      duration: const Duration(milliseconds: 750 ),
      builder: (context,double val,child){
        final translateY = (1 - val) * 50;
        return Opacity(
          opacity: val,
          child: Transform.translate(
          offset: Offset(translateY,0),
          child: child,
          ),
        );
    },
        child: child,



    );
  }
}
