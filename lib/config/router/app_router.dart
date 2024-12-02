import 'package:formsapp/presentation/screens/index.dart';
import 'package:formsapp/presentation/screens/notification_details_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/cubits",
    builder: (context, state) => const CubitCounterScreen(),
  ),
  GoRoute(
    path: "/bloc",
    builder: (context, state) => const BlocCounterScreen(),
  ),
  GoRoute(
    path: "/new-user",
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
      path: "/notifications",
      builder: (context, state) => const NotificationsScreen()),
  GoRoute(
      path: "/notifications-details/:pushMessageId",
      builder: (context, state) => NotificationDetailsScreen(
            pushMessageId: state.pathParameters["pushMessageId"] ?? "",
          )),
]);
