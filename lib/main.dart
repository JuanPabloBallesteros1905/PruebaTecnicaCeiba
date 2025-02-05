import 'package:flutter/material.dart';
import 'package:users/core/utils/colors.dart';
import 'package:users/features/users/presentation/screens/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              color: AppColors.mainColor,
              iconTheme: IconThemeData(color:AppColors.appBarIcons))),
      title: 'Material App',
      initialRoute: 'users',
      routes: {
        "users": (_) =>   UsersScreen(),
        "userDetails": (_) =>   UserDetails(),
      },
    );
  }
}
