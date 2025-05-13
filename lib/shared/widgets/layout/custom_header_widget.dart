import 'package:afinz_app/shared/widgets/appBars/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

abstract class BaseHeaderWidget extends StatelessWidget {
  final Widget? bottomNavigationWidget;
  final Color? backgroundColor;
  final Widget body;

  const BaseHeaderWidget({
    super.key,
    this.bottomNavigationWidget,
    this.backgroundColor,
    required this.body,
  });
}

class CustomHeaderWidget extends BaseHeaderWidget {
  const CustomHeaderWidget({
    super.key,
    super.bottomNavigationWidget,
    super.backgroundColor,
    required super.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.grey.shade100,
      bottomNavigationBar: bottomNavigationWidget,
      body: PopScope(
        canPop: false,
        child: body,
      ),
    );
  }

  static CustomHeaderWidgetExpanded expanded({
    Key? key,
    required String appBarTitle,
    required bool isLeadingIcon,
    VoidCallback? onTapLeadingIcon,
    Widget? bottomNavigationWidget,
    Color? backgroundColor,
    required Widget body,
  }) {
    return CustomHeaderWidgetExpanded(
      key: key,
      appBarTitle: appBarTitle,
      isLeadingIcon: isLeadingIcon,
      onTapLeadingIcon: onTapLeadingIcon,
      bottomNavigationWidget: bottomNavigationWidget,
      backgroundColor: backgroundColor,
      body: body,
    );
  }
}

class CustomHeaderWidgetExpanded extends BaseHeaderWidget {
  final String appBarTitle;
  final bool isLeadingIcon;
  final VoidCallback? onTapLeadingIcon;

  const CustomHeaderWidgetExpanded({
    super.key,
    required this.appBarTitle,
    required this.isLeadingIcon,
    this.onTapLeadingIcon,
    super.bottomNavigationWidget,
    super.backgroundColor,
    required super.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor ?? Colors.grey.shade100,
      appBar: CustomAppbarWidget(
        appBarTitle: appBarTitle,
        isLeadingIcon: isLeadingIcon,
        onTapLeadingIcon: onTapLeadingIcon,
      ),
      bottomNavigationBar: bottomNavigationWidget,
      body: body,
    );
  }
}
