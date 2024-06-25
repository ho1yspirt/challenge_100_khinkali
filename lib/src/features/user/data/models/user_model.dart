// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.points,
  });

  final String? id;
  final String? username;
  final int? points;

  UserModel copyWith({
    String? id,
    String? username,
    int? points,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'point': points,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      points: map['point'] != null ? map['point'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, username: $username, point: $points)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.username == username && other.points == points;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ points.hashCode;
}
