//Go router navigation
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/Calendar/calendar.dart';
import 'package:mood_tracker/Home/home.dart';
import 'package:mood_tracker/Stats_and_notifications/stats_notis.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        //Setting intial notification count to 0
        return HomeScreen(notificationCount: 0);
      },
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return CalendarScreen(moodEntries: data['moodEntries']);
      },
    ),
    GoRoute(
      path: '/stats_notis',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return StatsNotis(
          moodEntries: data['moodEntries'],
          notifications: data['notifications'],
        );
      },
    ),
  ],
);
