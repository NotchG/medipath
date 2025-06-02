import 'package:flutter/material.dart';
import 'package:medipath/pages/ChatDoctorPage/components/doctor_card.dart';
import 'package:medipath/pages/ChatDoctorPage/components/specialty_button.dart';

class ChatDoctorHomePage extends StatefulWidget {
  const ChatDoctorHomePage({super.key});

  @override
  State<ChatDoctorHomePage> createState() => _ChatDoctorHomePageState();
}

class _ChatDoctorHomePageState extends State<ChatDoctorHomePage> {

  final List<String> specialties = [
    "General Practitioner",
    "Heart Specialist",
    "Skin Specialist",
    "Liver Specialist",
    "Lung Specialist",
    "Intestine Specialist",
  ];

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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Chat with Doctor",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff22577A),
                  ),
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
                        "Available Doctors",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text("View All"),
                    )
                  ],
                ),
                SizedBox(height: 10),
                DoctorCard(
                  name: "Dr. John Doe",
                  specialty: "Cardiologist",
                  experienceYears: 10,
                ),
                DoctorCard(
                  name: "Dr. John Doe",
                  specialty: "Cardiologist",
                  experienceYears: 10,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Search Doctor by Specialty",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: specialties.map((specialty) {
                    return SpecialtyButton(
                      specialtyName: specialty,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
