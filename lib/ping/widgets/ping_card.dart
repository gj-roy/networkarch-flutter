// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:network_arch/models/animated_list_model.dart';
import 'package:network_arch/ping/repository/repository.dart';
import 'package:network_arch/shared/shared_widgets.dart';

class PingCard extends StatelessWidget {
  const PingCard({
    required this.hasError,
    required this.list,
    required this.item,
    Key? key,
  }) : super(key: key);

  final bool hasError;
  final AnimatedListModel<PingData?> list;
  final PingData item;

  @override
  Widget build(BuildContext context) {
    return DataCard(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 8.0, right: 16.0),
        leading: hasError
            ? const StatusCard(
                color: Colors.red,
                text: 'Error',
              )
            : const StatusCard(
                color: Colors.green,
                text: 'Online',
              ),
        subtitle: hasError
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Seq. pos.: ${list.indexOf(item) + 1}'),
                  const Text('TTL: N/A'),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Seq. pos.: ${item.response!.seq.toString()} '),
                  Text('TTL: ${item.response!.ttl.toString()}')
                ],
              ),
        trailing: SizedBox(
          width: 110,
          child: hasError
              ? Text(
                  context.read<PingRepository>().getErrorDesc(item.error!),
                )
              : Text(
                  '${item.response!.time!.inMilliseconds.toString()} ms',
                ),
        ),
      ),
    );
  }
}