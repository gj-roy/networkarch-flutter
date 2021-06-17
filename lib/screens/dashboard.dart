// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carrier_info/carrier_info.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:network_arch/constants.dart';
import 'package:network_arch/models/connectivity.dart';
import 'package:network_arch/utils/network_type.dart';
import 'package:network_arch/widgets/error_card.dart';
import 'package:network_arch/widgets/loading_card.dart';
import 'package:network_arch/widgets/network_card.dart';
import 'package:network_arch/widgets/tool_card.dart';
import '../widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    final Connectivity connectivity = Provider.of<Connectivity>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
        ),
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: connectivity.getWifiInfoStream,
                initialData: null,
                builder: (context, AsyncSnapshot<Map<int, Object>> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());

                    return ErrorCard(isDark: isDark);
                  }

                  if (!snapshot.hasData) {
                    return LoadingCard(isDark: isDark);
                  } else {
                    bool isWifiConnected =
                        snapshot.data[1] != null ? true : false;

                    return NetworkCard(
                      isDarkTheme: isDark, // TODO: By provider?
                      isNetworkConnected: isWifiConnected,
                      networkType: NetworkType.wifi,
                      bssidOrCarrier: snapshot.data[0] ?? "N/A",
                      ipAddress: snapshot.data[1] ?? "N/A",
                      onPressed: () {
                        // TODO: Implement onTap()
                      },
                    );
                  }
                },
              ),
              StreamBuilder(
                stream: connectivity.getCellularInfoStream,
                initialData: null,
                builder: (context, AsyncSnapshot<CarrierData> snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.hasError) {
                    print(snapshot.error);

                    return ErrorCard(isDark: isDark);
                  }

                  if (!snapshot.hasData) {
                    print("no data from snapshot");

                    return LoadingCard(isDark: isDark);
                  } else {
                    bool isCellularConnected =
                        snapshot.data.carrierName != null ? true : false;

                    return NetworkCard(
                      isDarkTheme: isDark,
                      isNetworkConnected: isCellularConnected,
                      networkType: NetworkType.cellular,
                      bssidOrCarrier: "UPC2137420",
                      ipAddress: "192.168.0.1",
                      onPressed: () {
                        // TODO: Implement onTap()
                      },
                    );
                  }
                },
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),

              //! debug
              // Observer(builder: (_) {
              //   return Text(connectivityStore.networkInterfaces.toString());
              // }),
              // TextButton(
              //   child: Text("update"),
              //   onPressed: () {
              //     connectivityStore.updateInterfaces();
              //   },
              // )

              ToolCard(
                isDarkTheme: isDark,
                toolName: "Ping",
                toolDesc: Constants.pingDesc,
                onPressed: () {
                  Navigator.pushNamed(context, "/tools/ping");
                },
              ),
              ToolCard(
                isDarkTheme: isDark,
                toolName: "LAN Scanner",
                toolDesc: Constants.lanScannerDesc,
                onPressed: () {
                  // TODO: Implement onTap()
                },
              ),
              ToolCard(
                isDarkTheme: isDark,
                toolName: "Wake On LAN",
                toolDesc: Constants.wolDesc,
                onPressed: () {
                  // TODO: Implement onTap()
                },
              ),
              ToolCard(
                isDarkTheme: isDark,
                toolName: "IP Geolocation",
                toolDesc: Constants.ipGeoDesc,
                onPressed: () {
                  // TODO: Implement onTap()
                },
              ),
              ToolCard(
                isDarkTheme: isDark,
                toolName: "Whois",
                toolDesc: Constants.whoisDesc,
                onPressed: () {
                  // TODO: Implement onTap()
                },
              ),
              ToolCard(
                isDarkTheme: isDark,
                toolName: "DNS Lookup",
                toolDesc: Constants.dnsDesc,
                onPressed: () {
                  // TODO: Implement onTap()
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}