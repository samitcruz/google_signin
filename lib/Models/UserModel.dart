import 'dart:convert';

class UserModel {
  String? uid;
  String? fullName;
  String? email;
  UserModel({
    this.uid,
    this.fullName,
    this.email,
  });

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap(user) {
    return {
      'uid': user.uid,
      'fullName': user.fullName,
      'email': user.email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
    );
  }

  String toJson(user) => json.encode(toMap(user));

  factory UserModel.fromJson(String user) =>
      UserModel.fromMap(json.decode(user));

  @override
  String toString() =>
      'UserModel(uid: $uid, fullName: $fullName, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ fullName.hashCode ^ email.hashCode;
}
