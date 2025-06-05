import 'package:flutter/material.dart';
import 'package:mood_tracker/Count/count_provider.dart';
import 'package:mood_tracker/Home/home.dart';
import 'package:mood_tracker/Mode/mode.dart';
import 'package:mood_tracker/Mood/mood_border.dart';
import 'package:mood_tracker/Notifications/noti_service.dart';
import 'package:provider/provider.dart';

void main() {
  //Ensure that an instance of WidgetsFlutterBinding is initialized before calling runApp()
  WidgetsFlutterBinding.ensureInitialized();

  //Initialise app start up notification
  NotiService().initNotification().then((_) {
    NotiService().showNotification(
      title: 'Welcome',
      body: 'Ready to track your mood?',
    );
  });

  runApp(
    MultiProvider(
      providers: [
        //Handles light/dark mode switching
        ChangeNotifierProvider(create: (context) => ModeController()),

        //Handles highlighting mood and reason selection 
        ChangeNotifierProvider(create: (context) => BorderController()),

        //Handles updating the notification count after they've been deleted
        ChangeNotifierProvider(create: (context) => CountProvider())
      ],
      child: const MyApp(),
    ),
  );
}

// Go router navigation
// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => HomeScreen()
//     ),
//     GoRoute(
//       path: '/calendar',
//       builder: (context, state) => CalendarScreen()
//     ),
//     GoRoute(
//       path: '/stats_notis',
//       builder: (context, state) => StatsNotis()
//     ),
//   ]
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Access the mode controller to determine the app's theme
    final modeController = Provider.of<ModeController>(context);

    return MaterialApp(
      theme: ThemeData(
        // Dynamically applies light or dark theme based on user preference
        brightness: modeController.isDarkMode
            ? Brightness.dark
            : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      //Setting intial notification count to 0
      home: HomeScreen(notificationCount: 0),
    );
  }
}
