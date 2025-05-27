import 'package:trexxo_mobility/models/address_model.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String dateOfBirth;
  final String? profileImageUrl;
  final List<AddressModel>? addresses;
  final bool agreedToTnC;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dateOfBirth,
    this.addresses,
    this.profileImageUrl,
    required this.agreedToTnC,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      profileImageUrl: json['profileImageUrl'],
      addresses:
          (json['addresses'] as List<dynamic>? ?? [])
              .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      agreedToTnC: json['agreedToTnC'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'dateOfBirth': dateOfBirth,
      'addresses': addresses!.map((e) => e.toJson()).toList(),
      'profileImageUrl': profileImageUrl,
      'agreedToTnC': agreedToTnC,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? dateOfBirth,
    String? profileImageUrl,
    List<AddressModel>? addresses,
    bool? agreedToTnC,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      addresses: addresses ?? this.addresses,
      agreedToTnC: agreedToTnC ?? this.agreedToTnC,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
