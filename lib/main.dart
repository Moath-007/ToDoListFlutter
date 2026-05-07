import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/Login.dart';
import 'services/AuthProvider.dart';
import 'services/TaskProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.red,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("My App"),
          ),
          body: Login(),
        ),
      ),
    );
  }
}



