import 'package:flutter/material.dart';

import 'PaymentPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton Stadium Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StadiumInfoPage(),
    );
  }
}

class StadiumInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/seed/picsum/800/200', // Placeholder image URL
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Badminton Stadium',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '4.5', // Replace with your stadium rating
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Location: Colombo', // Add your stadium location here
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        ': +1234567890', // Add your stadium phone number here
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  const Text(
                    'Description:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Available Time Slots:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Use a Wrap for the time slots to handle scrolling if needed
                  buildTimeSlotsList(context, [
                    'Monday: 10:00 AM - 12:00 PM',
                    'Wednesday: 3:00 PM - 5:00 PM',
                    'Friday: 6:00 PM - 8:00 PM',
                    'Saturday: 2:00 PM - 4:00 PM',
                    'Sunday: 5:00 PM - 7:00 PM',
                  ]),
                  const SizedBox(height: 16.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the list of time slots using Wrap
  Widget buildTimeSlotsList(BuildContext context, List<String> timeSlots) {
    return Wrap(
      spacing: 8.0, // Adjust the spacing as needed
      runSpacing: 8.0, // Adjust the run spacing as needed
      children: timeSlots
          .map(
            (slot) => GestureDetector(
          onTap: () {
            showBookingConfirmationDialog(context, slot);
          },
          child: Chip(
            label: Text(slot),
          ),
        ),
      )
          .toList(),
    );
  }

  // Function to show the booking confirmation dialog
  void showBookingConfirmationDialog(BuildContext context, String timeSlot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: Text('Do you want to book the court for $timeSlot?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                navigateToPaymentPage(context, timeSlot);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Function to navigate to the payment page
  void navigateToPaymentPage(BuildContext context, String timeSlot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          stadiumName: 'Badminton Stadium',
          location: 'Colombo',
          timeSlot: timeSlot,
          price: calculatePrice(), // Replace with your pricing logic
        ),
      ),
    );
  }

  double calculatePrice() {
    // Replace this with your pricing logic based on the selected time slot and any other factors
    return 20.0; // Example price
  }
}