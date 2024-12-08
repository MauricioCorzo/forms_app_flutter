part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  const NotificationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class NotificationRecived extends NotificationsEvent {
  final PushMessage message;
  const NotificationRecived(this.message);

  @override
  List<Object> get props => [message];
}
