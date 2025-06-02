import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/doctor_card.dart';

class ChatDoctorBySpecialtyPage extends StatefulWidget {
  final String specialtyName;
  const ChatDoctorBySpecialtyPage({super.key, required this.specialtyName});

  @override
  State<ChatDoctorBySpecialtyPage> createState() => _ChatDoctorBySpecialtyPageState();
}

class _ChatDoctorBySpecialtyPageState extends State<ChatDoctorBySpecialtyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFDF3F2),
                Color(0xffABB6DC)
              ],
            )
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.goNamed('chatdoctor');
                      },
                      icon: Icon(Icons.arrow_back, color: Color(0xff22577A))
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Chat with Doctor",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff22577A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search for a doctor",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Color(0xff22577A)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.specialtyName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DoctorCard(
                    name: "Dr. John Doe",
                    specialty: "Cardiologist",
                    experienceYears: 10,
                  ),
                  DoctorCard(
                    name: "Dr. Jane Smith",
                    specialty: "Neurologist",
                    experienceYears: 8,
                  ),
                  DoctorCard(
                    name: "Dr. Emily Johnson",
                    specialty: "Pediatrician",
                    experienceYears: 5,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
