import 'dart:io';
import 'package:admin_project/models/token_model.dart';
import 'package:admin_project/shared/database/services/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_project/models/user_model.dart';
import 'package:admin_project/screens/profile_screen/cubit/profile_screen_states.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  String? promotionValue;
  List<String> itemsPro = [
    'Assistant',
    'Doctor',
  ];

  void changePromotionState(String newValue) {
    this.promotionValue = newValue;
    emit(ChangePromotionState());
  }

////////////////////////////////////////////////
  String? departMentValue;
  List<String> itemsDep = [
    'Sc',
    'IS',
    'IT',
    'HR',
  ];

  void changeDepState(String newValue) {
    this.departMentValue = newValue;
    emit(ChangeDepState());
  }

//////////////////////////////////////////////////
  String? miltrayServiceValue;
  List<String> itemsMilitry = [
    'Finished',
    'Exemption',
    'Delay',
  ];

  void changeMiliteyState(String newValue) {
    this.miltrayServiceValue = newValue;
    emit(ChangeMilitryState());
  }

  IconData iconData = Icons.edit;
  UserModel? userModel;
  String? uid;
  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  final User? _user = FirebaseAuth.instance.currentUser;

  var isBottomSheetShowing = false;

  ProfileScreenCubit() : super(InitialState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShowing = isShow;
    this.iconData = icon;
    emit(ChangeBottomSheetState());
  }

  void getUserInfo() {
    uid = _user!.uid;
    FirebaseFirestore.instance
        .collection(USERS)
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userModel = UserModel.fromJson(element.data());
        emit(GetUserInfoSuccess());
      });

    }).catchError((error) {
      print(error.toString());
      emit(GetUserInfoFailed());
    });
  }

  Future getProfileImage(uid) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage(uid);
      emit(SelectImageStateSucess());
    } else {
      print('No Image Selected');
      emit(SelectImageStateFaluire());
    }
  }

  void uploadProfileImage(String uid) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            '${USERS}/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(uid)
            .update({'image': value});
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future getCoverImage(String uid) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      _uploadCoverImage(uid);
      emit(SelectImageCoverStateSucess());
    } else {
      print('No Image Selected');
      emit(SelectImageCoverStateFaluire());
    }
  }

  void _uploadCoverImage(uid) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${USERS}/cover/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(uid)
            .update({'cover': value});
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future updateUserInfo(uid, Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection(USERS)
        .doc(uid)
        .update(map)
        .then((value) {
      getUserInfo();
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future sendNotificationForUser(String type, String uid) async {
    if (type == 'pro') {
      updateUserInfo(uid, {
        "jobDesc": "${promotionValue}",
      });
    } else if (type == 'dep') {
      updateUserInfo(uid, {
        "department": "${departMentValue}",
      });
    }

    await FirebaseFirestore.instance
        .collection('Token')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        TokenModel tokenModel = TokenModel.fromJson(element.data());
        final data = {
          "to": "${tokenModel.token}",
          "notification": {
            "body": type == 'pro'
                ? "You Have Been promoted ! "
                : "You Have Been Move To anthor Depament ! ",
            "title": type == 'pro' ? "Promotion ! " : "Change Department",
            "sound": "default"
          },
          "android": {
            "priority": "HIGH",
            "notification": {
              "notification_priority": "PRIORITY_HIGH",
              "sound": "default",
              "default_sound": true,
              "default_vibrate_timings": true,
              "default_light_settings": true,
            },
          },
          "data": {
            "type": "order",
            "id": "87",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          }
        };
        DioHelper().postData(path: 'fcm/send', data: data).then((value) {
          if (value.statusCode == 200) {}
        }).catchError((error) {
          print(error.toString());
        });
      });
    });
  }

  void kickUser(uid) {
    print(uid);
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(uid)
        .update({"isActive": "s"});
  }
}
