import 'package:admin_project/models/attend_model.dart';
import 'package:admin_project/screens/AttendScreen/attend_cubit/attens_state.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttendCubit extends Cubit<AttendState> {
  List listAttend = [];


  AttendCubit() : super(InitialState());

  static AttendCubit get(context) => BlocProvider.of(context);

  void getAttends() {
    String monthDay = DateFormat.MMMd().format(DateTime.now());
    FirebaseFirestore.instance.collection(monthDay).get().then((value) {
      value.docs.forEach((element) {
        listAttend.add(AttendModel.fromMap(element.data()));
        emit(GetAttendState());
      });
    });
  }
}
