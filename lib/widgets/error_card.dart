// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:network_arch/widgets/data_card.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DataCard(
      color: isDark ? Colors.grey[800] : Colors.grey[200],
      cardChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.timesCircle,
              color: Colors.red,
              size: 25,
            ),
            SizedBox(height: 10),
            Text(
              "Unable to read data",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}