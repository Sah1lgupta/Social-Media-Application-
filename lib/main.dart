
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:testing2/screens/auth/login_screen.dart';
import 'package:testing2/screens/bottom_navigation_bar.dart';
import 'package:testing2/screens/splash_screen.dart';



import 'firebase_options.dart';

//global object for accessing device screen size
 Size mq= Size(0, 0);

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
 // await Permission.photos.request();
//  runApp(const MyApp());

//enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final List<Widget> pages = [
  // PostScreen(imageUrl: 'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png', username: 'username', caption: 'caption', comments: [Comment(username: 'username', text: 'text', timeAgo: 'timeAgo')]),
   // ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {

 //return BottomNav();
    return LoginScreen();
  }
}


_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}