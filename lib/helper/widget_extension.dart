import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget backgroundColor({Color? color}) {
    return ColoredBox(
      color: color ?? Colors.transparent,
      child: this,
    );
  }

  Widget margin({
    double? horizontal,
    double? vertical,
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? all,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget button(
      {required Function() onPressed,
      Color? backgroundColor,
      double? borderRadius,
      double? elevation}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation ?? 0),
          overlayColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.2),
          ),
          backgroundColor:
              MaterialStateProperty.all(backgroundColor ?? Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
          ),
        ),
        child: this);
  }
}
