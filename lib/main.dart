import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/pages/AuthPage/login_page.dart';
import 'package:medipath/pages/AuthPage/register_page.dart';
import 'package:provider/provider.dart';

import 'nav_handler.dart'; // Your NavHandler from previous steps
import 'package:medipath/pages/HomePage/home_page.dart';
import 'package:medipath/pages/HomePage/article_page.dart';
import 'package:medipath/pages/ChatBotPage/chatbot_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_home_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_by_specialty_page.dart';
import 'package:medipath/model/article_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavHandler(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navHandler = context.watch<NavHandler>();
    final currentIndex = navHandler.currentTabIndex;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(
          navHandler.tabInfos.length,
          (index) => ActiveTabWrapper(
            isActive: currentIndex == index,
            child: Router(
              routerDelegate: navHandler.tabInfos[index].router.routerDelegate,
              routeInformationParser: navHandler.tabInfos[index].router.routeInformationParser,
              routeInformationProvider: navHandler.tabInfos[index].router.routeInformationProvider,
            ),
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        activeColor: Color(0xff44157D),
        backgroundColor: Color(0xffB6A4C6),
        color: Color(0xff44157D),
        style: TabStyle.react,
        items: const [
          TabItem(
              icon: Icons.home_filled
          ),
          TabItem(
              icon: Icons.chat_bubble_rounded
          ),
          TabItem(
              icon: Icons.local_hospital_rounded
          ),
          TabItem(
              icon: Icons.person
          ),
        ],
        initialActiveIndex: currentIndex,
        onTap: (index) => navHandler.currentTabIndex = index,
      ),
    );
  }
}

class ActiveTabWrapper extends StatelessWidget {
  const ActiveTabWrapper({
    Key? key,
    required this.child,
    required this.isActive,
  }) : super(key: key);

  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: isActive,
      child: Offstage(
        offstage: !isActive,
        child: TickerMode(
          enabled: isActive,
          child: child,
        ),
      ),
    );
  }
}