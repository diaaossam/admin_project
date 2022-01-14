import 'package:bloc/bloc.dart';
import 'package:admin_project/screens/register/cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void regiterNewUser(
      {required context,
      required String email,
      required String password}) async {
    emit(RegisterLoadingSignInState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          Navigator.pop(context);
          //buildToast(msg: 'Success');
      //navigateTo(context, CompleteProfileScreen());
    }).catchError((error) {
      emit(RegisterFailureSignInState(error));
    });
  }


}
