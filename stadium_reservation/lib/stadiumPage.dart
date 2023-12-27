import 'package:flutter/material.dart';
import 'package:stadium_reservation/ConfirmBooking.dart';

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

class StadiumInfoPage extends StatefulWidget {
  @override
  _StadiumInfoPageState createState() => _StadiumInfoPageState();
}

class _StadiumInfoPageState extends State<StadiumInfoPage> {
  List<bool> _selections = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://sportsvenuecalculator.com/wp-content/uploads/2022/06/2-1.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                            '4.5',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Description:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Available Time Slots:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
<<<<<<< Updated upstream
                  SizedBox(height: 8.0),
                  buildTimeSlotsList([
=======
                  const SizedBox(height: 8.0),
                  // Use a Wrap for the time slots to handle scrolling if needed
                  buildTimeSlotsList(context, [
>>>>>>> Stashed changes
                    'Monday: 10:00 AM - 12:00 PM',
                    'Wednesday: 3:00 PM - 5:00 PM',
                    'Friday: 6:00 PM - 8:00 PM',
                    'Saturday: 2:00 PM - 4:00 PM',
                    'Sunday: 5:00 PM - 7:00 PM',
                  ]),
<<<<<<< Updated upstream
                  SizedBox(height: 16.0),
                  Text(
                    'Location:\nYour Stadium Address',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'Phone Number: +1234567890',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
=======
                  const SizedBox(height: 16.0)
>>>>>>> Stashed changes
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Reserve Button
// Reserve Button
SizedBox(height: 16.0),

// Selectable Booking Type
ToggleButtons(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Recurring Booking'),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('One-Time Booking'),
    ),
  ],
  isSelected: _selections,
  onPressed: (int index) {
    setState(() {
      // Deselect all buttons
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = i == index;
      }
    });
  },
),

SizedBox(height: 16.0),

// Reserve Button
ElevatedButton(
  onPressed: () {
    // Navigate to ConfirmBookingPage when Reserve button is pressed
    _navigateToConfirmBookingPage(context);
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
      'Reserve',
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

<<<<<<< Updated upstream
  Widget buildTimeSlotsList(List<String> timeSlots) {
=======
  // Function to build the list of time slots using Wrap
  Widget buildTimeSlotsList(BuildContext context, List<String> timeSlots) {
>>>>>>> Stashed changes
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
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

<<<<<<< Updated upstream
  void _navigateToConfirmBookingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmBookingPage(
          courtName: 'Badminton Stadium',
          timeSlot: 'Monday: 10:00 AM - 12:00 PM',
          courtNo: 'Court 1',
          price: 'LKR 800.00',
=======
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
>>>>>>> Stashed changes
        ),
      ),
    );
  }
<<<<<<< Updated upstream
}
=======

  double calculatePrice() {
    // Replace this with your pricing logic based on the selected time slot and any other factors
    return 20.0; // Example price
  }
}
>>>>>>> Stashed changes
