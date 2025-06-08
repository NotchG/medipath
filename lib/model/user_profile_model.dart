class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? address;
  final List<String>? medicalHistory;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.address,
    this.medicalHistory,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    DateTime? date = DateTime.tryParse(json['dateOfBirth'] ?? "");
    return UserProfile(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: date,
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      medicalHistory: (json['medicalHistory'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}