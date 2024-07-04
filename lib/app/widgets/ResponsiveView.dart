import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';


class ResponsiveView extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const ResponsiveView({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var width = constraints.maxWidth;
          if (width > 1200) {
            return ResponsiveViewMaxWidthBox(
              child: child,
            );
          }else{
            return ResponsiveViewScaledBox(
              child: child,
            );
          }
        },
      ),
    );
  }
}

class ResponsiveViewMaxWidthBox extends StatelessWidget {
  final Widget child;
  const ResponsiveViewMaxWidthBox({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    return MaxWidthBox(
        maxWidth: 1500,
        alignment: Alignment.center,
        background: Container(
          color: Colors.grey.shade200,
        ),
        child: child
    );
  }
}

class ResponsiveViewScaledBox extends StatelessWidget {
  final Widget child;
  const ResponsiveViewScaledBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
        width: 1200,
        child: child
    );
  }
}