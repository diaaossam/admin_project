import 'package:admin_project/screens/AttendScreen/attend_screen.dart';
import 'package:admin_project/screens/rest_screen/rest_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_project/models/token_model.dart';
import 'package:admin_project/screens/genrate_qr_code/qr_code.dart';
import 'package:admin_project/screens/request_screen/requests_screen.dart';
import 'package:admin_project/screens/users_screen/users_screen.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:admin_project/shared/database/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'MainLayoutStates.dart';

class MainLayoutCubit extends Cubit<MainLayoutStates> {
  int currentIndex = 0;
  final User? _user = FirebaseAuth.instance.currentUser;

  MainLayoutCubit() : super(InitialState());

  List<String> title = [
    'Attend Screen',
    'Rest Today',
    'UsersScreen',
    'QrCodeGenrator',
    'Request Page',

  ];

  List<BottomNavigationBarItem> bottomNavList = [
    BottomNavigationBarItem(
        icon: Icon(Icons.image),
        label: 'Attend'),
    BottomNavigationBarItem(
      icon: Icon(Icons.holiday_village),
      label: 'Rest Today',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle_sharp),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code),
      label: 'Qr Genrator',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: 'Requests',
    ),

  ];

  List<Widget> screens = [
    AttendScreen(),
    RestScreen(),
    UsersScreen(),
    QrCodeGenrator(),
    RequestScreen(),

  ];

  static MainLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  void changeBottomNavIndex(BuildContext context, int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  bool isDark = false;

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CachedHelper.saveData(key: DARK_MODE, value: null).then((value) {
      emit(ChangeAppThemeState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getToken() {
    String uid = _user!.uid;
    FirebaseMessaging.instance.getToken().then((value) {
      TokenModel tokenModel =
      TokenModel(uid: uid, isAdmin: true, token: value.toString());

      FirebaseFirestore.instance
          .collection('Token')
          .doc(uid)
          .set(tokenModel.toMap());
    });
  }
  void signOut(){
    FirebaseAuth.instance.signOut();

  }
}
