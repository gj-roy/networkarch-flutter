// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Constants {
  static ThemeData themeDataLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static ThemeData themeDataDark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static CupertinoThemeData cupertinoThemeData = CupertinoThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemGrey6,
      darkColor: CupertinoColors.black,
    ),
    barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemGrey6.withOpacity(0.7),
      darkColor: CupertinoColors.black.withOpacity(0.7),
    ),
  );

  // Colors
  static Color lightBgColor = Colors.grey[100]!;
  static Color iOSlightBgColor = CupertinoColors.white;

  static Color darkBgColor = Colors.grey[900]!;
  static Color iOSdarkBgColor = CupertinoColors.systemGrey5;

  static Color lightBtnColor = Colors.grey[300]!;
  static Color iOSlightBtnColor = CupertinoColors.systemGrey4;

  static Color darkBtnColor = Colors.grey[800]!;
  static Color iOSdarkBtnColor = CupertinoColors.systemGrey4;

  // Description styles
  static TextStyle descStyleLight = TextStyle(color: Colors.grey[600]);

  static TextStyle descStyleDark = TextStyle(color: Colors.grey[400]);

  // Tools descriptions
  static const String pingDesc =
      'Send packets to specific IP address or domain';

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

  static const String unknownError = 'No reply received from the host';

  static const String unknownHostError = 'No reply received from the host';

  static const String requestTimedOutError = 'No reply received from the host';

  // Permissions descriptions
  static const String locationPermissionDesc =
      'We need your location permission in order to access Wi-Fi information';

  // Permissions snackbars
  static const String _permissioGranted = 'Permission granted.';

  static const String _permissionDenied =
      '''Permission denied, the app may not function properly, check the app's settings.''';

  static const String _permissionDefault =
      'Something gone wrong, check app permissions.';

  static Widget permissionGrantedToast = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.greenAccent[400],
    ),
    child: Row(
      children: const [
        FaIcon(
          FontAwesomeIcons.checkCircle,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            _permissioGranted,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  static Widget permissionDeniedToast = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red,
    ),
    child: Row(
      children: [
        const FaIcon(
          FontAwesomeIcons.timesCircle,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            _permissionDenied,
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: const Text(
            'Open Settings',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );

  static Widget permissionDefaultToast = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.yellow[600],
    ),
    child: Row(
      children: [
        const FaIcon(
          FontAwesomeIcons.exclamationTriangle,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            _permissionDefault,
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: const Text(
            'Open Settings',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );

  static void showToast(FToast instance, toastBody) {
    instance.showToast(
      child: toastBody,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  // Wake On Lan snackbars
  static const String _wolValidationError =
      '''The IP address or MAC address is not valid, please check it and try again.''';

  static Widget wolValidationFault = SnackBar(
    content: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Row(
        children: const [
          FaIcon(
            FontAwesomeIcons.timesCircle,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              _wolValidationError,
            ),
          ),
        ],
      ),
    ),
  );
}
