import 'dart:convert';

Availability availabilityFromJson(String str) =>
    Availability.fromJson(json.decode(str));

String availabilityToJson(Availability data) => json.encode(data.toJson());

class Availability {
  final Day? monday;
  final Day? tuesday;
  final Day? wednesday;
  final Day? thursday;
  final Day? friday;
  final Day? saturday;
  final Day? sunday;

  Availability({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Availability copyWith({
    Day? monday,
    Day? tuesday,
    Day? wednesday,
    Day? thursday,
    Day? friday,
    Day? saturday,
    Day? sunday,
  }) =>
      Availability(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        monday: json["monday"] == null ? null : Day.fromJson(json["monday"]),
        tuesday: json["tuesday"] == null ? null : Day.fromJson(json["tuesday"]),
        wednesday:
            json["wednesday"] == null ? null : Day.fromJson(json["wednesday"]),
        thursday:
            json["thursday"] == null ? null : Day.fromJson(json["thursday"]),
        friday: json["friday"] == null ? null : Day.fromJson(json["friday"]),
        saturday:
            json["saturday"] == null ? null : Day.fromJson(json["saturday"]),
        sunday: json["sunday"] == null ? null : Day.fromJson(json["sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday?.toJson(),
        "tuesday": tuesday?.toJson(),
        "wednesday": wednesday?.toJson(),
        "thursday": thursday?.toJson(),
        "friday": friday?.toJson(),
        "saturday": saturday?.toJson(),
        "sunday": sunday?.toJson(),
      };
}

class Day {
  final bool? isAvailable;
  final NingShift? morningShift;
  final NingShift? eveningShift;

  Day({
    this.isAvailable,
    this.morningShift,
    this.eveningShift,
  });

  Day copyWith({
    bool? isAvailable,
    NingShift? morningShift,
    NingShift? eveningShift,
  }) =>
      Day(
        isAvailable: isAvailable ?? this.isAvailable,
        morningShift: morningShift ?? this.morningShift,
        eveningShift: eveningShift ?? this.eveningShift,
      );

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        isAvailable: json["isAvailable"],
        morningShift: json["morningShift"] == null
            ? null
            : NingShift.fromJson(json["morningShift"]),
        eveningShift: json["eveningShift"] == null
            ? null
            : NingShift.fromJson(json["eveningShift"]),
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "morningShift": morningShift?.toJson(),
        "eveningShift": eveningShift?.toJson(),
      };
}

class NingShift {
  final String? startTime;
  final String? endTime;

  NingShift({
    this.startTime,
    this.endTime,
  });

  NingShift copyWith({
    String? startTime,
    String? endTime,
  }) =>
      NingShift(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  factory NingShift.fromJson(Map<String, dynamic> json) => NingShift(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}
