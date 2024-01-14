import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String stadiumName;
  final String location;
  final String timeSlot;
  final double price;

  // Dummy user data
  final String userName = 'john_doe';
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'john.doe@example.com';
  final List<dynamic> court;

  PaymentPage({
    required this.stadiumName,
    required this.location,
    required this.timeSlot,
    required this.price,
    required this.court
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int countdownSeconds = 15;
  List<String> courtNameStrings = [];

  @override
  void initState() {
    super.initState();
    startCountdown();
    courtNameStrings = widget.court.map((e) => e.toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Your Booking '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        'Booking Receipt',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Courier',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildCard('First Name', widget.firstName),
                      _buildCard('Last Name', widget.lastName),
                      _buildCard('Email', widget.email),
                      _buildCard('Stadium Name', widget.stadiumName),
                      _buildCard('Location', widget.location),
                      _buildCard('Time Slot', widget.timeSlot),
                      _buildCard('Price', '\$${widget.price.toStringAsFixed(2)}'),
                      _buildCard('Courts', courtNameStrings.first),                    ],
                  ),
                ),
                SizedBox(height: 36.0),
                ElevatedButton(
                  onPressed: () {
                    showBookingConfirmation(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Pay',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  color: Colors.grey[200],
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(Icons.lock, color: Colors.red),
                    title: Text(
                      'Court is locked : $countdownSeconds remaining',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),

    );
  }
  Widget _buildCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (countdownSeconds > 0) {
        setState(() {
          countdownSeconds--;
        });
        startCountdown();
      } else {
        // Lock the court or perform any other action after countdown
        // For now, we'll just print a message
        print('Court locked!');
        Navigator.of(context).pop(); // Close the payment page
      }
    });
  }

  void showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Confirmed'),
          content: Text(
              'Hello ${widget.firstName} ${widget.lastName}, your badminton court has been booked for ${widget.timeSlot} at ${widget.stadiumName}. The total price is \$${widget.price.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
