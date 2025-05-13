import 'package:flutter/material.dart';

class CustomEyeValue extends StatelessWidget {
  final String title;
  final String value;
  final String cents;
  final VoidCallback onTap;
  final bool isNotEye;
  final bool hideEye;
  const CustomEyeValue({
    super.key,
    required this.title,
    required this.value,
    required this.cents,
    required this.onTap,
    required this.isNotEye,
    required this.hideEye,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isNotEye
            ? const SizedBox.shrink()
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
        Row(
          mainAxisAlignment:
              isNotEye ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            const Text(
              'R\$',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: Color(0xFFB5B5B5),
              ),
            ),
            hideEye
                ? Container(
                    height: 4,
                    width: 134,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C5CB),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        '$value,',
                        style: const TextStyle(
                          fontSize: 64,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF00C5CB),
                        ),
                      ),
                      Text(
                        cents,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB5B5B5),
                        ),
                      ),
                    ],
                  ),
            isNotEye ? const SizedBox.shrink() : const Spacer(),
            isNotEye
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: onTap,
                    iconSize: 20,
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  ),
          ],
        ),
      ],
    );
  }
}
