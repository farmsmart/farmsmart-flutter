import 'package:flutter/material.dart';
import 'Dogtag.dart';

class PositiveDogTagStyle implements DogTagStyle {

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0));

  final Color backgroundColor = const Color(0x1425df0c);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff25df0c));

  final int maxLines = 1;
  final double iconSize = 8;
  final double spacing = 5.5;

  const PositiveDogTagStyle();
}

class NegativeDogTagStyle implements DogTagStyle {
  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0));

  final Color backgroundColor = const Color(0x14ff8d4f);

  final EdgeInsets edgePadding = const EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xffff8d4f));

  final int maxLines = 1;
  final double iconSize = 8;
  final double spacing = 5.5;

  const NegativeDogTagStyle();
}

class CompactDogTag implements DogTagStyle {
  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0));

  final Color backgroundColor = const Color(0x1425df0c);

  final EdgeInsets edgePadding = const EdgeInsets.only(left: 12, top: 5.5, right: 12, bottom: 5.5);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));

  final int maxLines = 1;
  final double iconSize = 8;
  final double spacing = 5.5;

  const CompactDogTag();
}