import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/pages/HomePage/home_page.dart';
import 'package:medipath/pages/HomePage/article_page.dart';
import 'package:medipath/pages/ChatBotPage/chatbot_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_home_page.dart';
import 'package:medipath/pages/ChatDoctorPage/chat_doctor_by_specialty_page.dart';
import 'package:medipath/model/article_model.dart';
import 'package:medipath/pages/HospitalPage/hospital_list_page.dart';
import 'package:medipath/pages/ProfilePage/profile_page.dart';

class TabInfo {
  final String id;
  final GoRouter router;

  TabInfo({required this.id, required this.router});
}

class NavHandler extends ChangeNotifier {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  set currentTabIndex(int v) {
    if (_currentTabIndex != v) {
      _currentTabIndex = v;
      notifyListeners();
    }
  }

  NavHandler();

  late final List<TabInfo> tabInfos = [
    TabInfo(
      id: 'home',
      router: GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'article',
                name: 'article',
                builder: (context, state) {
                  final article = state.extra as ArticleModel?;
                  return ArticlePage(article: article);
                },
              ),
            ],
          ),
        ],
      ),
    ),
    TabInfo(
      id: 'chatbot',
      router: GoRouter(
        initialLocation: '/chatbot',
        routes: [
          GoRoute(
            path: '/chatbot',
            builder: (context, state) => const ChatbotPage(),
          ),
        ],
      ),
    ),
    TabInfo(
      id: 'hospital',
      router: GoRouter(
        initialLocation: '/hospital',
        routes: [
          GoRoute(
            path: '/hospital',
            builder: (context, state) => const HospitalListPage(),
            routes: [
              GoRoute(
                path: '/detail',
                name: 'chatdoctorspecialty',
                builder: (context, state) {
                  final specialty = state.pathParameters['specialty'];
                  return ChatDoctorBySpecialtyPage(specialtyName: specialty ?? 'General Practitioner');
                },
              ),
            ],
          ),
        ],
      ),
    ),
    TabInfo(
      id: 'profile',
      router: GoRouter(
        initialLocation: '/profile',
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ),
    TabInfo(
      id: 'chatdoctor',
      router: GoRouter(
        initialLocation: '/chatdoctor',
        routes: [
          GoRoute(
            path: '/chatdoctor',
            builder: (context, state) => const ChatDoctorHomePage(),
            routes: [
              GoRoute(
                path: ':specialty',
                name: 'chatdoctorspecialty',
                builder: (context, state) {
                  final specialty = state.pathParameters['specialty'];
                  return ChatDoctorBySpecialtyPage(specialtyName: specialty ?? 'General Practitioner');
                },
              ),
            ],
          ),
        ],
      ),
    ),
  ];
}