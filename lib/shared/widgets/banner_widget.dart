import 'package:flutter/material.dart';

class CustomBannerWidget extends StatelessWidget {
  const CustomBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 68,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.copy_all_outlined),
          ),
          const SizedBox(
            width: 16,
          ),
          const Column(
            children: [
              Text(
                'Conta: 678-9',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF00C5CB),
                ),
              ),
              Text(
                'Agencia: 1234',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB5B5B5),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
