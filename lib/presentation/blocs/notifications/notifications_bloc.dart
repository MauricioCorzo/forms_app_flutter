import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:formsapp/doamin/entities/push_message.dart';
import 'package:formsapp/firebase_options.dart';
import 'package:formsapp/helpers/logger.dart';
import 'package:permission_handler/permission_handler.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // firebase_messaging package instance
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_onNotificationStatusChange);
    on<NotificationRecived>(_onNotificationRecived);
    TLoggerHelper.info('NotificationsBloc initialized');
    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void initializeOnBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void _initialStatusCheck() async {
    final isGranted = await Permission.notification.isGranted;

    if (isGranted) {
      changeNotificationStatus(AuthorizationStatus.authorized);

      _getFirebaseClientToken();
      return;
    }

    // Check if the user has denied the permission for the first time or permanently whit the permission_handler package
    // because the firebase_messaging package does not provide this functionality for Android 33+
    final hasBeenDeniedFirstTime =
        await Permission.notification.shouldShowRequestRationale;
    final isPermanentlyDenied =
        await Permission.notification.isPermanentlyDenied;

    if (isPermanentlyDenied || hasBeenDeniedFirstTime) {
      changeNotificationStatus(AuthorizationStatus.denied);
      return;
    }
  }

  void _getFirebaseClientToken() async {
    // final settings = await messaging.getNotificationSettings();

    if (state.status == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      TLoggerHelper.info('Token: $token');
    }
  }

  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final PushMessage notification = PushMessage(
      messageId: message.messageId?.replaceAll(RegExp(r'[:%]'), "") ?? "",
      title: message.notification!.title ?? "",
      body: message.notification!.body ?? "",
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    addNotification(notification);
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void requestPermission() async {
    // final hasBeenDeniedFirstTime =
    //     await Permission.notification.shouldShowRequestRationale;
    // final isPermanentlyDenied =
    //     await Permission.notification.isPermanentlyDenied;

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

  void _onNotificationRecived(
      NotificationRecived event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(
      notifications: [event.message, ...state.notifications],
    ));
  }

  void addNotification(PushMessage message) {
    add(NotificationRecived(message));
  }

  PushMessage? getPushMessageById(String pushMessageId) {
    try {
      return state.notifications.firstWhere(
        (element) => element.messageId == pushMessageId,
      );
    } catch (e) {
      TLoggerHelper.error('Push message not found', e);
      return null;
    }
  }
}
