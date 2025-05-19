import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:medipath/pages/HomePage/home_page.dart';

void main() {
  runApp(const MaterialApp(
    home: MainApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home_filled),
          TabItem(icon: Icons.chat_bubble_rounded),
          TabItem(icon: Icons.history_rounded),
          TabItem(icon: Icons.person)
        ],
        color: Color(0xff2D3568),
        activeColor: Color(0xff2D3568),
        backgroundColor: Color(0xff7A87C2),
        curveSize: 100,
        style: TabStyle.react,
        height: 70,
      ),
    );
  }
}