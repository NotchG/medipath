class UpdateProfileRequest {
  final String? fullName;
  final String? gender;
  final String? dateOfBirth; // Format: "YYYY-MM-DD"
  final String? phoneNumber;
  final String? address;

  UpdateProfileRequest({
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.address,
  });

  Map<String, dynamic> toJson() => {
    if (fullName != null) 'fullName': fullName,
    if (gender != null) 'gender': gender,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (address != null) 'address': address,
  };
}