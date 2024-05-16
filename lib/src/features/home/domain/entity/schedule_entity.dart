// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ScheduleEntity {
  final String id;
  final String userId;
  final String studioId;
  final String orderId;
  final String paymentId;
  final String time;
  final String studioName;
  final DateTime date;
  final String userName;
  final String usernumber;
  final String userEmail;
  final String status;
  ScheduleEntity({
    required this.id,
    required this.userId,
    required this.studioId,
    required this.orderId,
    required this.paymentId,
    required this.time,
    required this.studioName,
    required this.date,
    required this.userName,
    required this.usernumber,
    required this.userEmail,
    required this.status,
  });

  ScheduleEntity copyWith({
    String? userId,
    String? studioId,
    String? orderId,
    String? paymentId,
    String? time,
    String? studioName,
    DateTime? date,
    String? userName,
    String? usernumber,
    String? userEmail,
    String? id,
    String? status,
  }) {
    return ScheduleEntity(
      status: status??this.status,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      studioId: studioId ?? this.studioId,
      orderId: orderId ?? this.orderId,
      paymentId: paymentId ?? this.paymentId,
      time: time ?? this.time,
      studioName: studioName ?? this.studioName,
      date: date ?? this.date,
      userName: userName ?? this.userName,
      usernumber: usernumber ?? this.usernumber,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'studioId': studioId,
      'orderId': orderId,
      'paymentId': paymentId,
      'time': time,
      'studioName': studioName,
      'date': date.millisecondsSinceEpoch,
      'userName': userName,
      'usernumber': usernumber,
      'userEmail': userEmail,
    };
  }

  static empty() => ScheduleEntity(
      id: 'id',
      userId: 'userId',
      studioId: 'studioId',
      orderId: 'orderId',
      paymentId: 'paymentId',
      time: 'time',
      studioName: 'studioName',
      date: DateTime.now(),
      userName: 'userName',
      usernumber: 'usernumber',
      status: 'accepted',
      userEmail: 'userEmail');

  factory ScheduleEntity.fromMap(Map<String, dynamic> map) {
    return ScheduleEntity(
      status: map['status'] as String,
      id: map['id'] as String,
      userId: map['userId'] as String,
      studioId: map['studioId'] as String,
      orderId: map['orderId'] as String,
      paymentId: map['paymentId'] as String,
      time: map['time'] as String,
      studioName: map['studioName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userName: map['userName'] as String,
      usernumber: map['usernumber'] as String,
      userEmail: map['userEmail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleEntity.fromJson(String source) =>
      ScheduleEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScheduleEntity(userId: $userId, studioId: $studioId, orderId: $orderId, paymentId: $paymentId, time: $time, studioName: $studioName, date: $date, userName: $userName, usernumber: $usernumber, userEmail: $userEmail)';
  }

  @override
  bool operator ==(covariant ScheduleEntity other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.studioId == studioId &&
        other.orderId == orderId &&
        other.paymentId == paymentId &&
        other.time == time &&
        other.studioName == studioName &&
        other.date == date &&
        other.userName == userName &&
        other.usernumber == usernumber &&
        other.userEmail == userEmail;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        studioId.hashCode ^
        orderId.hashCode ^
        paymentId.hashCode ^
        time.hashCode ^
        studioName.hashCode ^
        date.hashCode ^
        userName.hashCode ^
        usernumber.hashCode ^
        userEmail.hashCode;
  }
}
