import 'package:flutter/material.dart';

class TextKu extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign align;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextKu(
    this.text, {
    super.key,
    this.size = 18,
    this.weight = FontWeight.w500,
    this.color = Colors.black,
    this.align = TextAlign.left,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: 1.4, // biar lebih enak dibaca
        letterSpacing: 0.3, // subtle modern feel
      ),
    );
  }
}