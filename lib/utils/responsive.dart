import 'package:flutter/material.dart';

// Device type enum
enum DeviceType { mobile, tablet, desktop }

// Responsive configuration class
class ResponsiveConfig {
  static const double mobileBreakpoint = 500;
  static const double tabletBreakpoint = 1100;

  // Get current device type based on width
  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    }
    return DeviceType.desktop;
  }

  // Font sizes for different device types
  static double getFontSize(BuildContext context, double baseSize) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return baseSize;
      case DeviceType.tablet:
        return baseSize * 1.1;
      case DeviceType.desktop:
        return baseSize * 1.2;
    }
  }

  // Padding values for different device types
  static EdgeInsets getPadding(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        );
      case DeviceType.tablet:
        return const EdgeInsets.all(24.0);
      case DeviceType.desktop:
        return const EdgeInsets.all(32.0);
    }
  }

  // Max width constraints for different device types
  static double getMaxWidth(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return 500;
      case DeviceType.tablet:
        return 900;
      case DeviceType.desktop:
        return 1200;
    }
  }
}
