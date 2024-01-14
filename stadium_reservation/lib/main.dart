import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:stadium_reservation/Landing.dart' as landing;
import 'package:stadium_reservation/signUpPage.dart' as signup;

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

class HomePage extends StatelessWidget {
  TextEditingController _emailPhoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail(String email) {
    // Simple email validation - checks if email contains '@'
    return email.contains('@');
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Simple phone number validation - checks if it has 10 digits
    return phoneNumber.replaceAll(RegExp(r'\D'), '').length == 10;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.black,
          Colors.grey.shade900,
          Colors.grey.shade800
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: const Text(
                        "ENASH ACTIVE",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: _emailPhoneController,
                                    decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              String emailOrPhone =
                                  _emailPhoneController.text.trim();
                              String password = _passwordController.text.trim();
                    
                              if (_isValidEmail(emailOrPhone)) {
                                // Email is valid, you can proceed
                                // TODO: Add your sign-in logic here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          landing.LandingPage()),
                                );
                              } else if (_isValidPhoneNumber(emailOrPhone)) {
                                // Phone number is valid, you can proceed
                                // TODO: Add your sign-in logic here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          landing.LandingPage()),
                                );
                              } else {
                                // Invalid email or phone number
                                _showErrorDialog(
                                    context, "Invalid email or phone number");
                              }
                            },
                            height: 50,
                            color: Color.fromARGB(255, 1, 157, 223),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup.SignUpPage()),
                            );
                          },
                          child: FadeInUp(
                            duration: Duration(milliseconds: 1700),
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
