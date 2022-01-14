import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_project/models/user_model.dart';
import 'package:admin_project/screens/users_screen/cubit/user_states.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit() : super(InitialState());
  User ? user = FirebaseAuth.instance.currentUser;
  List<UserModel> usersList = [];

  static UsersCubit get(context) => BlocProvider.of(context);

  void getAllUsers() {
    FirebaseFirestore.instance
        .collection(USERS).where('uid', isNotEqualTo: user!.uid )
        .get()
        .then((value) {
          value.docs.forEach((element) {
            usersList.add(UserModel.fromJson(element.data()));
          });
          emit(OnGetUsersSuccess());
    })
        .catchError((error) {});
  }
}
