import 'package:flutter/material.dart';

GestureDetector containerToButton({
  required Widget child,
  required VoidCallback onPressed,
  Color? color,
  EdgeInsetsGeometry? padding,
  BorderRadiusGeometry? borderRadius,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: child,
    ),
  );
}
