import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formsapp/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context
            .select((NotificationsBloc bloc) => Text("${bloc.state.status}")),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
          ),
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.select((NotificationsBloc bloc) => bloc.state.notifications);
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text("Notification ${notifications[index].title}"),
            subtitle: Text(notifications[index].body),
            leading: notifications[index].imageUrl != null
                ? Image.network(notifications[index].imageUrl!)
                : const Icon(Icons.notifications_active_outlined),
            onTap: () {
              context.push(
                  '/notifications-details/${notifications[index].messageId}');
            });
      },
    );
  }
}
