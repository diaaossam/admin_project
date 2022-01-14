import 'package:admin_project/models/request_model.dart';
import 'package:admin_project/screens/rest_screen/rest_cubit/rest_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RestCubit extends Cubit<RestStates> {
  List listRest = [];
  String ? date;

  RestCubit() : super(InitialState());

  static RestCubit get(context) => BlocProvider.of(context);

  void getAllRest(){
    listRest.clear();
    FirebaseFirestore.instance.collection('rest')
        .where("date",isEqualTo:DateFormat.yMMMEd().format(DateTime.now()))

        .get().then((value) {
      value.docs.forEach((element) {
        listRest.add(RequestModel.fromMap(element.data()));
        emit(GetAllRest());
      });

    });
  }
}
