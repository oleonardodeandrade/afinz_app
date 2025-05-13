import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 2,
      thickness: 1,
      color: Color(0xFFB5B5B5),
    );
  }
}
