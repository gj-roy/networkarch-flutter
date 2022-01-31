// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:network_arch/ping/ping.dart';
import 'package:network_arch/screens/screens.dart';

// ignore_for_file: avoid-global-state

abstract class Constants {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/permissions': (context) => const PermissionsView(),
    // '/wifi': (context) => const WiFiDetailView(),
    '/cellular': (context) => const CellularDetailView(),
    '/tools/ping': (context) => const PingView(),
    '/tools/lan': (context) => const LanScannerView(),
    '/tools/wol': (context) => const WakeOnLanView(),
    // '/tools/ip_geo': (context) => const IPGeolocationView(),
  };

  static final ThemeData lightThemeData = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBgColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static final ThemeData darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBgColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static final CupertinoThemeData cupertinoThemeData = CupertinoThemeData(
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemGrey6,
      darkColor: CupertinoColors.black,
    ),
    barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemGrey6.withOpacity(0.8),
      darkColor: CupertinoColors.black.withOpacity(0.8),
    ),
  );

  // Styles
  static const EdgeInsets listPadding = EdgeInsets.all(10.0);

  static const double listSpacing = 10.0;

  static const Divider listDivider = Divider(
    height: 2,
    indent: 10,
    endIndent: 0,
  );

  // Colors
  static final Color lightBgColor = Colors.grey[100]!;
  static const Color iOSlightBgColor = CupertinoColors.white;
  static final Color darkBgColor = Colors.grey[900]!;
  static final Color iOSdarkBgColor = CupertinoColors.systemGrey6.darkColor;

  static final Color lightCardColor = Colors.grey[200]!;
  static final Color iOSlightCardColor = CupertinoColors.systemGrey5.color;
  static final Color darkCardColor = Colors.grey[850]!;
  static final Color iOSdarkCardColor = CupertinoColors.systemGrey5.darkColor;

  static final Color lightBtnColor = Colors.grey[300]!;
  static final Color iOSlightBtnColor = CupertinoColors.systemGrey6.color;
  static final Color darkBtnColor = Colors.grey[800]!;
  static final Color iOSdarkBtnColor = CupertinoColors.systemGrey4.darkColor;

  static Color getPlatformBgColor(BuildContext context) {
    final bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    return isDarkModeOn
        ? Platform.isAndroid
            ? Constants.darkBgColor
            : Constants.iOSdarkBgColor
        : Platform.isAndroid
            ? Constants.lightBgColor
            : Constants.iOSlightBgColor;
  }

  static Color getPlatformCardColor(BuildContext context) {
    final bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    return isDarkModeOn
        ? Platform.isAndroid
            ? Constants.darkCardColor
            : Constants.iOSdarkCardColor
        : Platform.isAndroid
            ? Constants.lightCardColor
            : Constants.iOSlightCardColor;
  }

  static Color getPlatformBtnColor(BuildContext context) {
    final bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    return isDarkModeOn
        ? Platform.isAndroid
            ? Constants.darkBtnColor
            : Constants.iOSdarkBtnColor
        : Platform.isAndroid
            ? Constants.lightBtnColor
            : Constants.iOSlightBtnColor;
  }

  // Description styles
  static final TextStyle descStyleLight = TextStyle(color: Colors.grey[600]);

  static final TextStyle descStyleDark = TextStyle(color: Colors.grey[400]);

  // Tools descriptions
  static const String pingDesc =
      'Send ICMP pings to specific IP address or domain';

  static const String lanScannerDesc =
      'Discover network devices in local network';

  static const String wolDesc = 'Send magic packets on your local network';

  static const String ipGeoDesc =
      'Get the geolocation of a specific IP address';

  static const String whoisDesc = 'Look up information about a specific domain';

  static const String dnsDesc = 'Get the DNS records of a specific domain';

  // Error descriptions
  static const String defaultError = "Couldn't read the data";

  static const String simError = 'No SIM card';

  static const String noReplyError = 'No reply received from the host';

  static const String unknownError = 'Unknown error';

  static const String unknownHostError = 'Unknown host';

  static const String requestTimedOutError = 'Request timed out';

  // Permissions descriptions
  static const String locationPermissionDesc =
      'We need your location permission in order to access Wi-Fi information';

  // Permissions snackbars
  static const String _permissionGranted = 'Permission granted.';

  static const String _permissionDenied =
      '''Permission denied, the app may not function properly, check the app's settings.''';

  static const String _permissionDefault =
      'Something gone wrong, check app permissions.';

  static final ElegantNotification permissionGrantedNotification =
      ElegantNotification.success(
    title: const Text('Success'),
    description: const Text(_permissionGranted),
    notificationPosition: NOTIFICATION_POSITION.bottom,
    animation: ANIMATION.fromBottom,
  );

  static final ElegantNotification permissionDeniedNotification =
      ElegantNotification.error(
    title: const Text('Error'),
    description: const Text(_permissionDenied),
    notificationPosition: NOTIFICATION_POSITION.bottom,
    animation: ANIMATION.fromBottom,
    action: TextButton(
      onPressed: () {
        openAppSettings();
      },
      child: const Text(
        'Open Settings',
      ),
    ),
  );

  static final ElegantNotification permissionDefaultNotification =
      ElegantNotification.error(
    title: const Text('Warning'),
    description: const Text(_permissionDefault),
    notificationPosition: NOTIFICATION_POSITION.bottom,
    animation: ANIMATION.fromBottom,
  );

  // Wake On Lan snackbars
  static const String _wolValidationError =
      '''The IP address or MAC address is not valid, please check it and try again.''';

  static final ElegantNotification wolValidationErrorNotification =
      ElegantNotification.error(
    title: const Text('Validation error'),
    description: const Text(_wolValidationError),
    notificationPosition: NOTIFICATION_POSITION.bottom,
    animation: ANIMATION.fromBottom,
    toastDuration: const Duration(milliseconds: 4000),
  );
}
