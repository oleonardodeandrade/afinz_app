import 'package:flutter/material.dart';

enum TextType {
  primaryAppbar,
  primaryTitle,
  primary,
  button,
  subTitle,
  subTitleMin,
}

final Map<TextType, TextStyle> textStyles = {
  TextType.primaryAppbar: const TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  TextType.primaryTitle: const TextStyle(
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  TextType.subTitle: const TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: Color(0xFFB5B5B5),
  ),
  TextType.subTitleMin: const TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: Color(0xFFB5B5B5),
  ),
  TextType.primary: const TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: Color(0xFF00C5CB),
  ),
  TextType.button: const TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: Color(0xFFFFFFFF),
  ),
};

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextType textType;
  const CustomTextWidget({
    super.key,
    required this.text,
    required this.textType,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyles[textType]);
  }
}
