import 'package:flutter/material.dart';

class ConfirmBookingPage extends StatelessWidget {
  final String courtName;
  final String timeSlot;
  final String price;
  final String courtNo;

  ConfirmBookingPage({
    required this.courtName,
    required this.timeSlot,
    required this.courtNo,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Court Name: $courtName',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Time Slot: $timeSlot',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // Proceed to Payment Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page
                _navigateToPaymentPage(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPaymentPage(BuildContext context) {
    // You can implement the navigation logic to the payment page here
    print('Navigate to Payment Page');
  }
}
