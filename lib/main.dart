import 'package:admin_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:admin_project/screens/startscreen/startscreen.dart';
import 'package:admin_project/shared/app_cubit/cubit_observer.dart';
import 'package:admin_project/shared/database/local/cache_helper.dart';
import 'package:admin_project/shared/database/services/dio_helper.dart';
import 'package:admin_project/style/styles.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print(' _firebaseMessagingBackgroundHandler  ${message.data.toString()}');
}
void main() {
  //Users
  // Qr Genrator
  // Requests
  // History
  // Settings

  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CachedHelper.init();
      await Firebase.initializeApp();
      DioHelper.init();
      FirebaseMessaging.onMessage.listen((event) {

        print('On Message  ${event.data.toString()}');
      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(' onMessageOpenedApp  ${event.data.toString()}');

      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileScreenCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: StartScreen(),
      ),
    );
  }
}
