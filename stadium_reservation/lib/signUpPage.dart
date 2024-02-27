import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stadium_reservation/Landing.dart' as landing;

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpPage(),
  ),
);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  Future<void> signUp() async {
    final url = Uri.parse('http://localhost:8080/api/auth/signup');
    try {
      final response = await http.post(
        url,
        body: {
          'username': usernameController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'contactNumber': mobileNumberController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        // Successful sign-up, navigate to landing page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => landing.LandingPage()),
        );
      } else {
        // Sign-up failed, display error message
        final responseData = json.decode(response.body);
        setErrorMessage('Sign-up failed: ${responseData['message']}');
      }
    } catch (error) {
      // Error occurred during sign-up
      setErrorMessage('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.grey.shade900,
                  Colors.grey.shade800
                ],
              ),
            ),
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
                        Text(
                          "ENASH ACTIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        buildTextField("First Name", firstNameController),
                        SizedBox(height: 10),
                        buildTextField("Last Name", lastNameController),
                        SizedBox(height: 10),
                        buildTextField("Mobile Number", mobileNumberController),
                        SizedBox(height: 10),
                        buildTextField("Email", emailController),
                        SizedBox(height: 10),
                        buildTextField("Username", usernameController),
                        SizedBox(height: 10),
                        buildTextField("Password", passwordController, isPassword: true),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text("Sign Up"),
                        ),
                        SizedBox(height: 10),
                        if (errorMessage.isNotEmpty)
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      String hintText,
      TextEditingController controller, {
        bool isPassword = false,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }
}
