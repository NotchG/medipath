class HospitalModel {
  final String name;
  final String address;
  final String region;
  final String phone;
  final String province;

  HospitalModel({
    required this.name,
    required this.address,
    required this.region,
    required this.phone,
    required this.province,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {

    return HospitalModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      region: json['region'] ?? '',
      phone: json['phone'] ?? '',
      province: json['province'] ?? '',
    );
  }
}