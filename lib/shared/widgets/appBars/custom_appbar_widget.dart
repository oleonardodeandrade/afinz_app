import 'package:afinz_app/shared/widgets/text/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String appBarTitle;
  final bool isLeadingIcon;
  final VoidCallback? onTapLeadingIcon;
  const CustomAppbarWidget({
    super.key,
    required this.appBarTitle,
    required this.isLeadingIcon,
    this.onTapLeadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 5.0,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      title:
          CustomTextWidget(text: appBarTitle, textType: TextType.primaryAppbar),
      leading: isLeadingIcon
          ? InkWell(
              onTap: onTapLeadingIcon ?? () {},
              child: const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.0,
                  color: Color(0xFF313944),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
