import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:formsapp/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // firebase_messaging package instance
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_onNotificationStatusChange);
    _initialStatusChcek();
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  void _initialStatusChcek() async {
    // Check if the user has denied the permission for the first time or permanently whit the permission_handler package
    // because the firebase_messaging package does not provide this functionality for Android 33+
    final hasBeenDeniedFirstTime =
        await Permission.notification.shouldShowRequestRationale;
    final isPermanentlyDenied =
        await Permission.notification.isPermanentlyDenied;

    print(
        'hasBeenDeniedFirstTime: $hasBeenDeniedFirstTime, isPermanentlyDenied: $isPermanentlyDenied');

    if (!isPermanentlyDenied && !hasBeenDeniedFirstTime) return;

    NotificationSettings settings = await messaging.getNotificationSettings();
    changeNotificationStatus(settings.authorizationStatus);

    _getFirebaseClientToken();
  }

  void _getFirebaseClientToken() async {
    // final settings = await messaging.getNotificationSettings();

    if (state.status == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print('Token: $token');
    }
  }

  void requestPermission() async {
    final hasBeenDeniedFirstTime =
        await Permission.notification.shouldShowRequestRationale;
    final isPermanentlyDenied =
        await Permission.notification.isPermanentlyDenied;

    print(
        'hasBeenDeniedFirstTime: $hasBeenDeniedFirstTime, isPermanentlyDenied: $isPermanentlyDenied');

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    changeNotificationStatus(settings.authorizationStatus);
  }

  void _onNotificationStatusChange(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(
      status: event.status,
    ));
    _getFirebaseClientToken();
  }

  void changeNotificationStatus(AuthorizationStatus status) {
    add(NotificationStatusChanged(status));
  }
}
