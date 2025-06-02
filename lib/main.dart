import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/model/article_model.dart';
import 'package:medipath/pages/ChatBotPage/chatbot_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_by_specialty_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_home_page.dart';
import 'package:medipath/pages/HomePage/article_page.dart';
import 'package:medipath/pages/HomePage/home_page.dart';

void main() {
  runApp(MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainApp(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/chatbot',
          builder: (context, state) => const ChatbotPage(),
        ),
        GoRoute(
          path: '/chatdoctor',
          name: 'chatdoctor',
          builder: (context, state) => const ChatDoctorHomePage()
        ),
        GoRoute(
          path: '/chatdoctor/:specialty',
          name: 'chatdoctorspecialty',
          builder: (context, state) {
            final specialty = state.pathParameters['specialty'];
            return ChatDoctorBySpecialtyPage(specialtyName: specialty ?? 'General Practitioner');
          },
        ),
        GoRoute(
          path: '/home/article',
          name: 'article',
          builder: (context, state) {
            ArticleModel? article = state.extra as ArticleModel?;
            return ArticlePage(article: article);
          }
        )
        // Add more GoRoute for other tabs/pages here
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainApp extends StatefulWidget {
  final Widget child;
  const MainApp({super.key, required this.child});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int get selectedIndex {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    // Add more index checks for other tabs
    return 0;
  }

  void _onTabTapped(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/chatbot');
        break;
      case 2:
        context.go('/chatdoctor');
        break;
    // Add more cases for other tabs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home_filled),
          TabItem(icon: Icons.chat_bubble_rounded),
          TabItem(icon: Icons.history_rounded),
          TabItem(icon: Icons.person),
        ],
        color: const Color(0xff2D3568),
        activeColor: const Color(0xff2D3568),
        backgroundColor: const Color(0xff7A87C2),
        curveSize: 100,
        style: TabStyle.react,
        height: 70,
        initialActiveIndex: selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}