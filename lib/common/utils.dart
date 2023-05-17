// import 'package:flutter/material.dart';
//
// GestureDetector containerToButton({
//   required Widget child,
//   required VoidCallback onPressed,
//   Color? color,
//   EdgeInsetsGeometry? padding,
//   BorderRadiusGeometry? borderRadius,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: Container(
//       decoration: BoxDecoration(
//         color: color ?? Colors.transparent,
//         borderRadius: borderRadius,
//       ),
//       padding: padding,
//       child: child,
//     ),
//   );
// }

// import 'package:flutter/material.dart';
//
// class ContainerWithGesture extends StatelessWidget {
//   final Widget child;
//   final GestureTapCallback onTap;
//
//   const ContainerWithGesture({
//     Key? key,
//     required this.child,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         child: child,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';


class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTile({Key? key, required this.imagePath, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white),
          color: Colors.grey[200],
        ),
        child: Image.asset(imagePath,height: 40,),
      ),
    );
  }
}

