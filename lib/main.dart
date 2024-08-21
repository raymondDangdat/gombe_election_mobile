import 'package:flutter/material.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/providers/ganache_connection_provider.dart';
import 'package:gombe_election/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ElectionProvider(context)),
        ChangeNotifierProvider(create: (context) => GanacheConnectionProvider()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}


