import 'package:flutter/material.dart';

class ContainerKu extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final double radius;
  final double blur;
  final Offset offset;
  final Color shadowColor;
  final double? width;
  final double? height;
  final VoidCallback? onTap; // 🔥 tambah interaksi
  final Border? border; // 🔥 optional border

  const ContainerKu({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(vertical: 6),
    this.color = Colors.white,
    this.radius = 16,
    this.blur = 12,
    this.offset = const Offset(0, 6),
    this.shadowColor = const Color(0x14000000),
    this.width,
    this.height,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: border ??
                  Border.all(
                    color: Colors.blue.shade200, // 🔥 subtle border
                  ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: blur,
                  offset: offset,
                ),
              ],
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );

    
  }
}