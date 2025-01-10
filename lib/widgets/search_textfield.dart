import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final FocusNode? focusNode;

  final String? hintText;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onSearch,
    this.focusNode,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveConfig.getDeviceType(context);
    final maxWidth = ResponsiveConfig.getMaxWidth(context);
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minWidth: 200,
        ),
        child: TextField(
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: textTheme.bodyLarge,
              suffixIcon: Container(
                height: _getIconButtonHeight(deviceType),
                width: 60,
                padding: EdgeInsets.zero,
                child: IconButton(
                  color: Colors.white,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(8),
                              left: Radius.circular(-8))))),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      onSearch(controller.text);
                    }
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    size: _getIconSize(deviceType),
                  ),
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              contentPadding: _getContentPadding(deviceType),
            ),
            style: textTheme.bodyLarge,
            controller: controller,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                onSearch(value);
              }
            },
            textInputAction: TextInputAction.go));
  }

  TextInputAction getInputAction() {
    if (controller.text.isNotEmpty) {
      return TextInputAction.go;
    }
    return TextInputAction.none;
  }

  double _getIconButtonHeight(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 40;
      case DeviceType.tablet:
        return 50;
      case DeviceType.desktop:
        return 60;
    }
  }

  double _getIconSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.tablet:
        return 24;
      case DeviceType.desktop:
        return 28;
    }
  }

  EdgeInsets _getContentPadding(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return EdgeInsets.symmetric(vertical: 12, horizontal: 10);
      case DeviceType.tablet:
        return EdgeInsets.symmetric(vertical: 15, horizontal: 12);
      case DeviceType.desktop:
        return EdgeInsets.symmetric(vertical: 18, horizontal: 14);
    }
  }
}
