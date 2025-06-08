import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/controller/register_controller.dart';
import 'package:medipath/model/register_model.dart';
import 'package:medipath/pages/AuthPage/components/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String fullName = "";
  String password = "";
  String confirmPassword = "";

  final RegisterController _registerController = RegisterController();

  void handleRegister() async {
    if (email.isEmpty || fullName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields.")),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

    final request = RegisterRequest(
      fullName: fullName,
      email: email,
      password: password,
    );
    final response = await _registerController.register(request);

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful! Please login.")),
      );
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed. Try again.")),
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
                        "Sign Up",
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
                          setState(() {
                            email = text;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      AuthTextField(
                        label: "Enter your username",
                        onChanged: (text) {
                          setState(() {
                            fullName = text;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      AuthTextField(
                        label: "Enter your password",
                        onChanged: (text) {
                          setState(() {
                            password = text;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      AuthTextField(
                        label: "Confirm your password",
                        onChanged: (text) {
                          setState(() {
                            confirmPassword = text;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE0DD26),
                          foregroundColor: Color(0xff44157D),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
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
                      context.go('/login');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: Color(0xffE0DD26),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
