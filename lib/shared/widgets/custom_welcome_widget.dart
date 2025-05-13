import 'package:flutter/material.dart';

class CustomWelcomeWidget extends StatelessWidget {
  final String namedUser;
  final VoidCallback onTap;
  const CustomWelcomeWidget({
    super.key,
    required this.namedUser,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $namedUser!',
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Text(
              'Confira como vai sua conta hoje',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: Color(0xFFB5B5B5),
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
      ],
    );
  }
}
