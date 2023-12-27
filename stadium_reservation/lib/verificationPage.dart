import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VerificationPage(),
  ),
);

class VerificationPage extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.black, Colors.grey.shade900, Colors.grey.shade800],
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
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
                          height: 20,
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
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                buildTextField(
                                  "Phone Number",
                                  phoneNumberController,
                                ),
                                SizedBox(height: 10),
                                buildTextField(
                                  "Verification Code",
                                  verificationCodeController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: MaterialButton(
                            onPressed: () {
                              if (_validateFields()) {
                                _showSuccessDialog(context);
                              }
                            },
                            height: 50,
                            color: Color.fromARGB(255, 1, 157, 223),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "Verify",
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  bool _validateFields() {
    if (phoneNumberController.text.isEmpty ||
        verificationCodeController.text.isEmpty) {
      // Show an error message or handle validation as needed
      // For now, just print a message to the console
      print("All fields must be filled.");
      return false;
    }
    return true;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Account Created Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
