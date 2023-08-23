import 'package:flutter/material.dart';
import 'package:tm_getx/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManagerApp.globalKey,
      title: 'Task Manager',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),

          )
        )
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
