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
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.sports_tennis, color: Colors.blueGrey),
                title: Text('Court Name'),
                subtitle: Text(courtName),
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.access_time, color: Colors.blueGrey),
                title: Text('Time Slot'),
                subtitle: Text(timeSlot),
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.attach_money, color: Colors.blueGrey),
                title: Text('Price'),
                subtitle: Text(price),
              ),
            ),
            SizedBox(height: 16.0),
            // Proceed to Payment Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page
                _navigateToPaymentPage(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
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