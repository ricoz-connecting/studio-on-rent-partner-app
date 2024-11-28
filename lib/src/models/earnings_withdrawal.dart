class Earnings {
  final int? availableBalance;
  final int totalEarning;
  final int totalWithdrawal;
  final int thisMonthEarning;
  final int todayEarning;
  final int thisMonthWithdrawal;
  final int todayWithdrawal;

  Earnings({
    this.availableBalance,
    required this.totalEarning,
    required this.totalWithdrawal,
    required this.thisMonthEarning,
    required this.todayEarning,
    required this.thisMonthWithdrawal,
    required this.todayWithdrawal,
  });

  Earnings copyWith({
    int? availableBalance,
    int? totalEarning,
    int? totalWithdrawal,
    int? thisMonthEarning,
    int? todayEarning,
    int? thisMonthWithdrawal,
    int? todayWithdrawal,
  }) =>
      Earnings(
        availableBalance: availableBalance ?? this.availableBalance,
        totalEarning: totalEarning ?? this.totalEarning,
        totalWithdrawal: totalWithdrawal ?? this.totalWithdrawal,
        thisMonthEarning: thisMonthEarning ?? this.thisMonthEarning,
        todayEarning: todayEarning ?? this.todayEarning,
        thisMonthWithdrawal: thisMonthWithdrawal ?? this.thisMonthWithdrawal,
        todayWithdrawal: todayWithdrawal ?? this.todayWithdrawal,
      );

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        availableBalance: json["availableBalance"] ?? 0.0,
        totalEarning: json["totalEarning"] ?? 0.0,
        totalWithdrawal: json["totalWithdrawal"] ?? 0.0,
        thisMonthEarning: json["thisMonthEarning"] ?? 0.0,
        todayEarning: json["todayEarning"] ?? 0.0,
        thisMonthWithdrawal: json["thisMonthWithdrawal"] ?? 0.0,
        todayWithdrawal: json["todayWithdrawal"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "availableBalance": availableBalance,
        "totalEarning": totalEarning,
        "totalWithdrawal": totalWithdrawal,
        "thisMonthEarning": thisMonthEarning,
        "todayEarning": todayEarning,
        "thisMonthWithdrawal": thisMonthWithdrawal,
        "todayWithdrawal": todayWithdrawal,
      };
}

class WithdrawalHistory {
  final int amount;
  final int serviceCharge;
  final DateTime date;
  final String transactionId;
  final String status;

  WithdrawalHistory({
    required this.amount,
    required this.serviceCharge,
    required this.date,
    required this.transactionId,
    required this.status,
  });

  WithdrawalHistory copyWith({
    int? amount,
    int? serviceCharge,
    DateTime? date,
    String? transactionId,
    String? status,
  }) =>
      WithdrawalHistory(
        amount: amount ?? this.amount,
        serviceCharge: serviceCharge ?? this.serviceCharge,
        date: date ?? this.date,
        transactionId: transactionId ?? this.transactionId,
        status: status ?? this.status,
      );

  factory WithdrawalHistory.fromJson(Map<String, dynamic> json) =>
      WithdrawalHistory(
        amount: json["amount"] ?? 0.0,
        serviceCharge: json["serviceCharge"] ?? 0.0,
        date: DateTime.parse(json["date"]),
        transactionId: json["transactionId"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "serviceCharge": serviceCharge,
        "date": date.toIso8601String(),
        "transactionId": transactionId,
        "status": status,
      };
}

class EarningsHistory {
  final String orderId;
  final String title;
  final String thumbnail;
  final String type;
  final String paymentStatus;
  final int amount;
  final DateTime date;

  EarningsHistory({
    required this.orderId,
    required this.title,
    required this.thumbnail,
    required this.type,
    required this.paymentStatus,
    required this.amount,
    required this.date,
  });

  EarningsHistory copyWith({
    String? orderId,
    String? title,
    String? thumbnail,
    String? type,
    String? paymentStatus,
    int? amount,
    DateTime? date,
  }) =>
      EarningsHistory(
        orderId: orderId ?? this.orderId,
        title: title ?? this.title,
        thumbnail: thumbnail ?? this.thumbnail,
        type: type ?? this.type,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );

  factory EarningsHistory.fromJson(Map<String, dynamic> json) =>
      EarningsHistory(
        orderId: json["orderId"] ?? "",
        title: json["title"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        type: json["type"] ?? "",
        paymentStatus: json["paymentStatus"] ?? "",
        amount: json["amount"] ?? 0.0,
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "title": title,
        "thumbnail": thumbnail,
        "type": type,
        "paymentStatus": paymentStatus,
        "amount": amount,
        "date": date.toIso8601String(),
      };
}
