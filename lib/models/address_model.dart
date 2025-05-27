class AddressModel {
  final String title;
  final String addressLine;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.title,
    required this.addressLine,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      title: json['title'] ?? '',
      addressLine: json['addressLine'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'addressLine': addressLine,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
