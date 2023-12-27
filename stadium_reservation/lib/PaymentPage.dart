import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String stadiumName;
  final String location;
  final String timeSlot;
  final double price; // Add the price for the booking

  PaymentPage({
    required this.stadiumName,
    required this.location,
    required this.timeSlot,
    required this.price,
  });

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
              subtitle: Text(stadiumName),
            ),
            ListTile(
              title: Text('Location'),
              subtitle: Text(location),
            ),
            ListTile(
              title: Text('Time Slot'),
              subtitle: Text(timeSlot),
            ),
            ListTile(
              title: Text('Price'),
              subtitle: Text('\$${price.toStringAsFixed(2)}'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showBookingConfirmation(context);
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  void showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmed'),
          content: Text('Your badminton court has been booked for $timeSlot at $stadiumName. The total price is \$${price.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the payment page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
