import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/pages/ProfilePage/components/profile_text_field.dart';
import 'package:medipath/controller/profile_controller.dart';
import 'package:medipath/model/user_profile_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../model/update_profile_req_model.dart';
import '../../nav_handler.dart';
import '../../provider/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullName = "";
  String gender = "Male";
  String email = "";
  String phoneNumber = "";
  String address = "";
  DateTime? selectedDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndSetProfile();
  }

  Future<void> _fetchAndSetProfile() async {
    final profile = await ProfileController().fetchProfile(context);
    if (profile != null) {
      setState(() {
        fullName = profile.fullName ?? "";
        gender = profile.gender ?? "Male";
        email = profile.email ?? "";
        phoneNumber = profile.phoneNumber ?? "";
        address = profile.address ?? "";
        if (profile.dateOfBirth != null) {
          selectedDate = profile.dateOfBirth;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                color: Color(0xff44157D),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 100,
                color: Color(0xff44157D),
              ),
              SizedBox(height: 20),
              Text(
                fullName.isNotEmpty ? fullName : "User Name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff44157D),
                ),
              ),
              SizedBox(height: 10),
              Text(
                email.isNotEmpty ? email : "Email Address",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xff44157D),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "This is necessary data for the hospital",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    ProfileTextField(
                      label: "Full Name",
                      initialValue: fullName,
                      onChanged: (text) {
                        setState(() {
                          fullName = text;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: gender,
                      items: [
                        DropdownMenuItem(
                          value: "Male",
                          child: Text(
                            "Male",
                            style: TextStyle(
                              color: Color(0xff44157D),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text(
                            "Female",
                            style: TextStyle(
                              color: Color(0xff44157D),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          gender = value;
                        });
                      },
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: _selectDate,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xff44157D),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          selectedDate != null
                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                              : 'Select Date',
                          style: TextStyle(
                            color: Color(0xff44157D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ProfileTextField(
                      label: "Phone Number",
                      initialValue: phoneNumber,
                      onChanged: (text) {
                        setState(() {
                          phoneNumber = text;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ProfileTextField(
                      label: "Address",
                      initialValue: address,
                      onChanged: (text) {
                        setState(() {
                          address = text;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        // Add Medical History action
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xff44157D),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Add Medical History',
                          style: TextStyle(
                            color: Color(0xff44157D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () async {
                        final request = UpdateProfileRequest(
                          fullName: fullName,
                          gender: gender,
                          dateOfBirth: selectedDate != null
                              ? "${selectedDate!.year.toString().padLeft(4, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                              : null,
                          phoneNumber: phoneNumber,
                          address: address,
                        );
                        final success = await ProfileController().updateProfile(context, request);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success ? "Profile updated!" : "Failed to update profile"),
                          ),
                        );
                        if (success) {
                          _fetchAndSetProfile(); // Optionally refresh profile data
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffE0DD26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Color(0xff44157D),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () async {
                        await context.read<AuthProvider>().logout();
                        Phoenix.rebirth(context); // This restarts the app
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Color(0xffFF3D00), width: 2),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: Color(0xffFF3D00),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
