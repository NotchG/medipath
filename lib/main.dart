import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/pages/AuthPage/login_page.dart';
import 'package:medipath/pages/AuthPage/register_page.dart';
import 'package:medipath/pages/AuthPage/splash_screen.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart'; // import your AuthProvider
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'nav_handler.dart'; // Your NavHandler from previous steps

void main() {
  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => NavHandler()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

final FlutterSecureStorage _storage = const FlutterSecureStorage();

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const MainApp(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    )
  ],
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Wait for AuthProvider to finish loading before redirecting
    if (authProvider.isLoading) {
      return state.matchedLocation == '/splash' ? null : '/splash';
    }

    if (state.matchedLocation == '/splash') {
      return null;
    }
    final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';
    final isLoggedIn = authProvider.isLoggedIn;

    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }
    if (isLoggedIn && isLoggingIn) {
      return '/';
    }
    return null;
  },
  refreshListenable: AuthProvider(), // Use your provider to trigger refresh
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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