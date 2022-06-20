// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:network_arch/constants.dart';
import 'package:network_arch/overview/views/overview_view.dart';
import 'package:network_arch/permissions/permissions.dart';
import 'package:network_arch/settings/settings.dart';
import 'package:network_arch/shared/shared_widgets.dart';
import 'package:network_arch/utils/in_app_purchases.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    context
        .read<PermissionsBloc>()
        .add(const PermissionsStatusRefreshRequested());

    _setUpInAppPurchases();
  }

  @override
  void dispose() {
    super.dispose();

    _subscription.cancel();
  }

  void _setUpInAppPurchases() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        listenToPurchaseUpdated(purchaseDetailsList, context);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        Sentry.captureException(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');
    final bool hasIntroductionBeenShown = settingsBox
        .get('hasIntroductionBeenShown', defaultValue: false) as bool;

    return hasIntroductionBeenShown
        ? PlatformWidget(
            androidBuilder: _androidBuilder,
            iosBuilder: _iosBuilder,
          )
        : PlatformWidget(
            androidBuilder: Constants.routes['/introduction'],
            iosBuilder: Constants.iOSroutes['/introduction'],
          );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text('Overview')
            : const Text('Settings'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Overview',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: 'Overview',
              routes: Constants.routes,
              builder: (context) => const OverviewView(),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: 'Settings',
              routes: Constants.routes,
              builder: (context) => const SettingsView(),
            );
          default:
            throw 'Unexpected tab';
        }
      },
    );
  }
}

const List<Widget> _pages = <Widget>[
  OverviewView(),
  SettingsView(),
];
