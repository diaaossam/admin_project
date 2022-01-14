import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_project/models/request_model.dart';
import 'package:admin_project/screens/request_screen/cubit/req_states.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RequestCubit extends Cubit<RequestStates> {
  List<RequestModel> reqList = [];
  CollectionReference reqRef = FirebaseFirestore.instance.collection(REQUEST);
  CollectionReference userOldRequests =
      FirebaseFirestore.instance.collection(OLD_REQUEST);

  RequestCubit() : super(InitialState());

  static RequestCubit get(context) => BlocProvider.of(context);

  //get Resuests
  void getAllRequests() {
    FirebaseFirestore.instance.collection(REQUEST).get().then((value) {
      value.docs.forEach((element) {
        reqList.add(RequestModel.fromMap(element.data()));
      });
      emit(GetRequestsStates());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void sendRequestReply(String uid, username, String reply, bool isRest) {
    if (isRest == false) {
      FirebaseFirestore.instance.collection(REQUEST).doc(uid).delete();
      if (reply == 'Reject') {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(uid)
            .update({"isActive": "ss"});
      } else if (reply == 'Accept') {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(uid)
            .update({"isActive": "active"});
      }
    }


    else if (isRest == true) {
      FirebaseFirestore.instance.collection(REQUEST).doc(uid).delete();
      if (reply == 'Accept') {
        FirebaseFirestore.instance
            .collection(uid)
            .doc(DateFormat.yMMMEd().format(DateTime.now()))
            .update({"response": "${reply}"});
      } else if (reply == 'Reject'){
        FirebaseFirestore.instance.collection('rest').doc(uid).delete();
        FirebaseFirestore.instance
            .collection(uid)
            .doc(DateFormat.yMMMEd().format(DateTime.now()))
            .update({"response": "${reply}"});
      }
 }
  }
}
