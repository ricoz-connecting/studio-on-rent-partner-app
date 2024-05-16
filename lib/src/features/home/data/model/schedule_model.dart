import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel(
      {required super.userId,
      required super.studioId,
      required super.orderId,
      required super.paymentId,
      required super.time,
      required super.studioName,
      required super.date,
      required super.userName,
      required super.usernumber,
      required super.userEmail,
      required super.id,
      required super.status});

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      status: map['status'] as String,
      id: map['id'] as String,
      userId: map['userId'] as String,
      studioId: map['studioId'] as String,
      orderId: map['orderId'] as String,
      paymentId: map['paymentId'] as String,
      time: map['time'] as String,
      studioName: map['studioName'] as String,
      date: DateTime.parse(map['date']),
      userName: map['userName'] as String,
      usernumber: map['usernumber'] as String,
      userEmail: map['userEmail'] as String,
    );
  }
}
