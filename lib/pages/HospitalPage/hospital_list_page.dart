import 'package:flutter/material.dart';
import 'package:medipath/controller/hospital_controller.dart';

import 'components/hospital_list_tile.dart';

class HospitalListPage extends StatefulWidget {
  const HospitalListPage({super.key});

  @override
  State<HospitalListPage> createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "MediPath",
              style: TextStyle(
                color: Color(0xff44157D),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.person,
              color: Colors.black,
              size: 24,
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari Rumah Sakit...",
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
            Expanded(
              child: FutureBuilder(
                future: HospitalController.fetchHospitals(), // Replace with your data fetching method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hospitals found.'));
                  } else {
                    final hospitals = snapshot.data!;
                    return ListView.builder(
                      itemCount: hospitals.length,
                      itemBuilder: (context, index) {
                        return HospitalListTile(hospital: hospitals[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
