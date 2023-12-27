import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String stadiumName;
  final String location;
  final String timeSlot;
  final double price;

  PaymentPage({
    required this.stadiumName,
    required this.location,
    required this.timeSlot,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int countdownSeconds = 15;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Booking Receipt',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Stadium Name'),
              subtitle: Text(widget.stadiumName),
            ),
            ListTile(
              title: Text('Location'),
              subtitle: Text(widget.location),
            ),
            ListTile(
              title: Text('Time Slot'),
              subtitle: Text(widget.timeSlot),
            ),
            ListTile(
              title: Text('Price'),
              subtitle: Text('\$${widget.price.toStringAsFixed(2)}'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showBookingConfirmation(context);
              },
              child: const Text('Pay'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Court is locked : $countdownSeconds remaining',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
              'Your badminton court has been booked for ${widget.timeSlot} at ${widget.stadiumName}. The total price is \$${widget.price.toStringAsFixed(2)}.'),
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
