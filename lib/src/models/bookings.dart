import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  final CustomerDetails customerDetails;
  final StudioDetails studioDetails;
  final PartnerDetails partnerDetails;
  final BookingDetails bookingDetails;
  final PaymentDetails paymentDetails;
  final String id;
  final String orderId;
  final String orderStatus;
  final String sellOrRent;
  final String orderDate;
  final String createdAt;
  final String updatedAt;

  Booking({
    required this.customerDetails,
    required this.studioDetails,
    required this.partnerDetails,
    required this.bookingDetails,
    required this.paymentDetails,
    required this.id,
    required this.orderId,
    required this.orderStatus,
    required this.sellOrRent,
    required this.orderDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        customerDetails: CustomerDetails.fromJson(json["customerDetails"]),
        studioDetails: StudioDetails.fromJson(json["studioDetails"]),
        partnerDetails: PartnerDetails.fromJson(json["partnerDetails"]),
        bookingDetails: BookingDetails.fromJson(json["bookingDetails"]),
        paymentDetails: PaymentDetails.fromJson(json["paymentDetails"]),
        id: json["_id"],
        orderId: json["orderId"],
        orderStatus: json["orderStatus"],
        sellOrRent: json["sellOrRent"],
        orderDate: json["orderDate"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "customerDetails": customerDetails.toJson(),
        "studioDetails": studioDetails.toJson(),
        "partnerDetails": partnerDetails.toJson(),
        "bookingDetails": bookingDetails.toJson(),
        "paymentDetails": paymentDetails.toJson(),
        "_id": id,
        "orderId": orderId,
        "orderStatus": orderStatus,
        "sellOrRent": sellOrRent,
        "orderDate": orderDate,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class CustomerDetails {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String customerDocId;

  CustomerDetails({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.customerDocId,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        customerDocId: json["customerDocId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "customerDocId": customerDocId,
      };
}

class StudioDetails {
  final Location location;
  final String studioName;
  final String type;
  final String category;
  final String about;
  final String address;
  final String thumbnail;
  final String studioDocId;

  StudioDetails({
    required this.location,
    required this.studioName,
    required this.type,
    required this.category,
    required this.about,
    required this.address,
    required this.thumbnail,
    required this.studioDocId,
  });

  factory StudioDetails.fromJson(Map<String, dynamic> json) => StudioDetails(
        location: Location.fromJson(json["location"]),
        studioName: json["studioName"],
        type: json["type"],
        category: json["category"],
        about: json["about"],
        address: json["address"],
        thumbnail: json["thumbnail"],
        studioDocId: json["studioDocId"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "studioName": studioName,
        "type": type,
        "category": category,
        "about": about,
        "address": address,
        "thumbnail": thumbnail,
        "studioDocId": studioDocId,
      };
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class PartnerDetails {
  final String partnerDocId;
  final String partnerName;
  final String phone;
  final String email;
  final String avatar;
  final String address;

  PartnerDetails({
    required this.partnerDocId,
    required this.partnerName,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.address,
  });

  factory PartnerDetails.fromJson(Map<String, dynamic> json) => PartnerDetails(
        partnerDocId: json["partnerDocId"],
        partnerName: json["partnerName"],
        phone: json["phone"],
        email: json["email"],
        avatar: json["avatar"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "partnerDocId": partnerDocId,
        "partnerName": partnerName,
        "phone": phone,
        "email": email,
        "avatar": avatar,
        "address": address,
      };
}

class BookingDetails {
  final String date;
  final String startTime;
  final String endTime;
  final String description;

  BookingDetails({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "description": description,
      };
}

class PaymentDetails {
  final DurationDetails duration;
  final Discount discount;
  final int subTotalAmount;
  final int taxAmount;
  final int paidAmount;
  final String paymentMode;
  final String paidAt;
  final String paymentStatus;

  PaymentDetails({
    required this.duration,
    required this.discount,
    required this.subTotalAmount,
    required this.taxAmount,
    required this.paidAmount,
    required this.paymentMode,
    required this.paidAt,
    required this.paymentStatus,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        duration: DurationDetails.fromJson(json["duration"]),
        discount: Discount.fromJson(json["discount"]),
        subTotalAmount: json["subTotalAmount"],
        taxAmount: json["taxAmount"],
        paidAmount: json["paidAmount"],
        paymentMode: json["paymentMode"],
        paidAt: json["paidAt"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration.toJson(),
        "discount": discount.toJson(),
        "subTotalAmount": subTotalAmount,
        "taxAmount": taxAmount,
        "paidAmount": paidAmount,
        "paymentMode": paymentMode,
        "paidAt": paidAt,
        "paymentStatus": paymentStatus,
      };
}


class DurationDetails {
  final String title;
  final int value;

  DurationDetails({
    required this.title,
    required this.value,
  });

  factory DurationDetails.fromJson(Map<String, dynamic> json) =>
      DurationDetails(
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

class Discount {
  final String discountType;
  final int discountValue;
  final String couponCode;

  Discount({
    required this.discountType,
    required this.discountValue,
    required this.couponCode,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        couponCode: json["couponCode"],
      );

  Map<String, dynamic> toJson() => {
        "discountType": discountType,
        "discountValue": discountValue,
        "couponCode": couponCode,
      };
}

