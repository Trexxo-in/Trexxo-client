import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trexxo_mobility/models/address_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final String? profileImageUrl;
  final List<AddressModel>? addresses;
  final bool agreedToTnC;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    this.addresses,
    this.profileImageUrl,
    required this.agreedToTnC,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      dob: json['dob'] ?? '',
      profileImageUrl: json['profileImageUrl'],
      addresses:
          (json['addresses'] as List<dynamic>? ?? [])
              .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      agreedToTnC: json['agreedToTnC'] ?? false,
      createdAt:
          (json['createdAt'] is Timestamp)
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'addresses': addresses?.map((e) => e.toJson()).toList(),
      'profileImageUrl': profileImageUrl,
      'agreedToTnC': agreedToTnC,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? mobile,
    String? dob,
    String? profileImageUrl,
    List<AddressModel>? addresses,
    bool? agreedToTnC,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      addresses: addresses ?? this.addresses,
      agreedToTnC: agreedToTnC ?? this.agreedToTnC,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
