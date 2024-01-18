import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
                        FadeInUp(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "ENASH ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "ACTIVE",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
                        SizedBox(
                          height: 40,
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
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                buildTextField(
                                  "First Name",
                                  firstNameController,
                                ),
                                SizedBox(height: 10),
                                buildTextField(
                                  "Last Name",
                                  lastNameController,
                                ),
                                SizedBox(height: 10),
                                buildTextField(
                                  "Mobile Number",
                                  mobileNumberController,
                                ),
                                SizedBox(height: 10),
                                buildTextField("Email", emailController),
                                SizedBox(height: 10),
                                buildTextField(
                                  "Username",
                                  usernameController,
                                ),
                                SizedBox(height: 10),
                                buildTextField(
                                  "Password",
                                  passwordController,
                                  isPassword: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: MaterialButton(
                            onPressed: () {
                              if(!validateEmail(emailController.text)){
                                setErrorMessage('Please use correct email address');
                              }
                              else if (!validateMobile(mobileNumberController.text)){
                                setErrorMessage('Please use correct Phone number');
                              }
                              else if (validateForm()) {
                                // All fields are filled, proceed with your logic
                                print('Form is valid');
                                // Navigate to the landing page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => landing.LandingPage()),
                                );
                              } else {
                                // Display an error message
                                setErrorMessage('Please fill in all fields');
                              }
                            },
                            height: 50,
                            color: Color.fromARGB(255, 1, 157, 223),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "Agree and Continue",
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

  bool validateForm() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;


  }

  Widget buildTextField(
      String hintText,
      TextEditingController controller, {
        bool isPassword = false,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        onChanged: (value) {
          // Clear the error message when any field changes
          clearErrorMessage();
        },
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

  void clearErrorMessage() {
    setState(() {
      errorMessage = '';
    });
  }

  bool validateEmail(String value) {
    return value.contains('@');
  }

  bool validateMobile(String value) {
    return value.replaceAll(RegExp(r'\D'), '').length == 10;

  }
}
