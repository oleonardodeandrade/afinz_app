import 'package:flutter/material.dart';

import '../text/custom_text_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;
  final bool isLoading;

  const CustomButtonWidget({
    super.key,
    required this.title,
    this.color,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
        height: 67,
        width: 354,
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF00C5CB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : CustomTextWidget(
                text: title,
                textType: TextType.button,
              ),
      ),
    );
  }
}
