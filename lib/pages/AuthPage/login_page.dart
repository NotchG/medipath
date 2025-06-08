import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/pages/AuthPage/components/auth_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medipath/controller/auth_controller.dart';
import 'package:medipath/model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:medipath/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String password = "";

  final AuthController _authController = AuthController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void handleLogin() async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email and password.")),
      );
      return;
    }

    final request = LoginRequest(email: email, password: password);
    final response = await _authController.login(request);

    if (response != null) {
      // Store both token and userId using the provider
      await context.read<AuthProvider>().setAuthData(
        token: response.token,
        userId: response.id.toString(), // or just response.id if it's already a string
      );
      context.go('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email or password.")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff44157D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(160),
                      bottomRight: Radius.circular(160),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image(
                      image: AssetImage("assets/images/AuthPage/LogoMediPath.png"),
                      height: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      AuthTextField(
                        label: "Enter your email",
                        onChanged: (text) {
                          // Handle username input
                          setState(() {
                            email = text;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      AuthTextField(
                        label: "Enter your password",
                        onChanged: (text) {
                          // Handle username input
                          setState(() {
                            password = text;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Handle login action
                          handleLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE0DD26),
                          foregroundColor: Color(0xff44157D),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Color(0xff44157D)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Color(0xffE0DD26),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(height: 5),
                  Text(
                    "By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Statement.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
