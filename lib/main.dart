import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/bottom_nav_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/providers/ganache_connection_provider.dart';
import 'package:gombe_election/resources/constants/color_constants.dart';
import 'package:gombe_election/resources/constants/dimension_constants.dart';
import 'package:gombe_election/resources/theme_manager.dart';
import 'package:gombe_election/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: white, // navigation bar color
    statusBarColor: white, // status bar color
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(
            create: (context) => GanacheConnectionProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(designScreenWidth, designScreenHeight),
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Gombe Election DApp',
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme(),
              home: const SplashScreen(),
            );
          }),
    );
  }
}
