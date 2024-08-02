import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_ui/features/landing/screens/landing_screen.dart';
import 'package:whatsapp_ui/firebase_options.dart';
import 'package:whatsapp_ui/router.dart';
import 'package:whatsapp_ui/screens/eb_screen_layout.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';
import 'package:whatsapp_ui/utils/responsive_layout.dart';

void main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }
  catch(err){
    print("error in initializing");
  }
  // to keep track and save all provider state
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp ui',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            // this appBar theme is followed for every screen unless you change
          appBarTheme: const AppBarTheme(
            color: appBarColor
          )
          ),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: const LandingScreen()
    );
  }
}
