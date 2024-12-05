import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formsapp/doamin/entities/push_message.dart';
import 'package:formsapp/presentation/blocs/notifications/notifications_bloc.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final String pushMessageId;
  const NotificationDetailsScreen({
    super.key,
    required this.pushMessageId,
  });

  @override
  Widget build(BuildContext context) {
    final PushMessage? pushMessage =
        context.watch<NotificationsBloc>().getPushMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: (pushMessage != null)
          ? _DetailsView(pushMessage: pushMessage)
          : const Center(child: Text('Notification not found')),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage pushMessage;
  const _DetailsView({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (pushMessage.imageUrl != null)
            Image.network(
              pushMessage.imageUrl!,
              width: 200,
            )
          else
            const Icon(Icons.notifications_active_outlined),
          const SizedBox(height: 30),
          Text(
            pushMessage.title,
            style: textStyles.titleMedium,
          ),
          SizedBox(
            width: 400,
            child: Text(
              pushMessage.body,
              textAlign: TextAlign.center,
              style: textStyles.bodyLarge,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(pushMessage.data.toString()),
        ],
      ),
    );
  }
}
