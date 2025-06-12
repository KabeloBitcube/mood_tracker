import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/Bloc/Calendar/calendar_cubit.dart';
import 'package:mood_tracker/Bloc/Stats_and_notifications/notifications_cubit.dart';
import 'package:mood_tracker/Bloc/observer.dart';
import 'package:mood_tracker/Provider/Mode/mode.dart';
import 'package:mood_tracker/Provider/Mood/mood_border.dart';
import 'package:mood_tracker/Notifications/noti_service.dart';
import 'package:mood_tracker/Provider/Reason/reason_border.dart';
import 'package:mood_tracker/Router/router.dart';
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

  //Initilize mood observer
  Bloc.observer = const Observer();

  runApp(
    MultiProvider(
      providers: [
        //Handles light/dark mode switching
        ChangeNotifierProvider(create: (context) => ModeController()),

        //Handles highlighting mood selection
        ChangeNotifierProvider(create: (context) => MoodController()),

        //Handles highlighting reason selection
        ChangeNotifierProvider(create: (context) => ReasonController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Access the mode controller to determine the app's theme
    final modeController = Provider.of<ModeController>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CalendarCubit>(create: (_) => CalendarCubit()),
        BlocProvider<NotificationsCubit>(create: (_) => NotificationsCubit()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          // Dynamically applies light or dark theme based on user preference
          brightness: modeController.isDarkMode
              ? Brightness.dark
              : Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}


