import 'dart:ui';
import 'package:flutter/material.dart';

class BluredContainer extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double borderColorOpacity;
  final BorderRadiusGeometry borderRadius;
  final double? blurSygmaX;
  final double? blurSygmaY;
  const BluredContainer({
    Key? key,
    required this.child,
    this.start = 0.3,
    this.end = 0.2,
    this.width,
    this.height,
    this.margin,
    this.blurSygmaX = 80,
    this.blurSygmaY = 80,
    this.borderColorOpacity = 0.3,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(AppConstants.radius)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: blurSygmaX ?? 80, sigmaY: blurSygmaY ?? 80),
        child: Container(
          // margin: margin,
          width: width ?? 420, // MediaQuery.of(context).size.width,
          height: height ?? 400, // MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(borderColorOpacity),
            ),
            // backgroundBlendMode: BlendMode.srcOver,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.white.withOpacity(0.1),
            //     blurRadius: 10,
            //     offset: const Offset(1, 1),
            //   ),
            // ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class AppConstants {
  static const double radius = 6;
  static const double borderRadius = 6;

  static Color whiteOpacity = Color.fromARGB(181, 255, 255, 255);
}

class GlassMaterial extends StatelessWidget {
  final Widget centerWidget;

  final List<Color> gradientColors;

  final Alignment alignment;

  final List<Widget> circleWidgets;
  const GlassMaterial({
    Key? key,
    required this.centerWidget,
    this.alignment = Alignment.center,
    this.gradientColors = const [
      Color(0xD52A76DA),
      Color(0xBDD43FCD),
    ],
    required this.circleWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors),
        ),
        child: Stack(
          children: [
            Stack(
              fit: StackFit.expand,
              children: circleWidgets,
            ),
            Align(
              alignment: alignment,
              child: centerWidget,
            ),
          ],
        ),
      ),
    );
  }
}
