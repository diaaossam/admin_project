class AttendModel {
  String date;
  bool isAttend;
  bool isRest;
  String userName;

  AttendModel(
      {required this.date,
      required this.isAttend,
      required this.isRest,
      required this.userName});

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'isAttend': this.isAttend,
      'isRest': this.isRest,
      'userName': this.userName,
    };
  }

  factory AttendModel.fromMap(Map<String, dynamic> map) {
    return AttendModel(
      date: map['date'] as String,
      isAttend: map['isAttend'] as bool,
      isRest: map['isRest'] as bool,
      userName: map['userName'] as String,
    );
  }
}
