import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color(0xff22577A),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Achmed Fidel",
                      style: TextStyle(
                        color: Color(0xff22577A)
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "Jalan Triman, Be...",
                      style: TextStyle(
                          color: Color(0xff22577A)
                      ),
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      color: Color(0xff22577A),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffABB6DC),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Color(0xff22577A),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                      "Welcome, Achmed Fidel\nLaki Laki | 36 Tahun\nTidak ada riwayat penyakit"
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
