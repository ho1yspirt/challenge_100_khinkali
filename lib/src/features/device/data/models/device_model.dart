// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:learn_flutter_aws/src/features/user/data/models/user_model.dart';

final class DeviceModel {
  DeviceModel({
    required this.address,
    required this.approvalsCount,
    required this.id,
    required this.location,
    required this.notes,
    required this.registrationDate,
    required this.status,
    required this.user,
  });

  final String address;
  final int approvalsCount;
  final String id;
  final LocationModel location;
  final String notes;
  final int registrationDate;
  final String status;
  final UserModel user;

  DeviceModel copyWith({
    String? address,
    int? approvalsCount,
    String? id,
    LocationModel? location,
    String? notes,
    int? registrationDate,
    String? status,
    UserModel? user,
  }) {
    return DeviceModel(
      address: address ?? this.address,
      approvalsCount: approvalsCount ?? this.approvalsCount,
      id: id ?? this.id,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      registrationDate: registrationDate ?? this.registrationDate,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'approvalsCount': approvalsCount,
      'id': id,
      'location': location.toMap(),
      'notes': notes,
      'registrationDate': registrationDate,
      'status': status,
      'user': user.toMap(),
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      address: map['address'] as String,
      approvalsCount: map['approvalsCount'] as int,
      id: map['id'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      notes: map['notes'] as String,
      registrationDate: map['registrationDate'] as int,
      status: map['status'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) => DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceModel(address: $address, approvalsCount: $approvalsCount, id: $id, location: $location, notes: $notes, registrationDate: $registrationDate, status: $status, user: $user)';
  }

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.approvalsCount == approvalsCount &&
        other.id == id &&
        other.location == location &&
        other.notes == notes &&
        other.registrationDate == registrationDate &&
        other.status == status &&
        other.user == user;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        approvalsCount.hashCode ^
        id.hashCode ^
        location.hashCode ^
        notes.hashCode ^
        registrationDate.hashCode ^
        status.hashCode ^
        user.hashCode;
  }
}

final class LocationModel {
  LocationModel({
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  LocationModel copyWith({
    double? lat,
    double? lon,
  }) {
    return LocationModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationModel(lat: $lat, lon: $lon)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
