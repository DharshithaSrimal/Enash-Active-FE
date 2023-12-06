import 'package:flutter/material.dart';

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/seed/picsum/800/200', // Placeholder image URL
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
                  SizedBox(height: 8.0),
                  // Use a Wrap for the time slots to handle scrolling if needed
                  buildTimeSlotsList([
                    'Monday: 10:00 AM - 12:00 PM',
                    'Wednesday: 3:00 PM - 5:00 PM',
                    'Friday: 6:00 PM - 8:00 PM',
                    'Saturday: 2:00 PM - 4:00 PM',
                    'Sunday: 5:00 PM - 7:00 PM',
                  ]),
                  SizedBox(height: 16.0),
                  Text(
                    'Location:\nYour Stadium Address', // Add your stadium location here
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
                        'Phone Number: +1234567890', // Add your stadium phone number here
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the list of time slots using Wrap
  Widget buildTimeSlotsList(List<String> timeSlots) {
    return Wrap(
      spacing: 8.0, // Adjust the spacing as needed
      runSpacing: 8.0, // Adjust the run spacing as needed
      children: timeSlots
          .map(
            (slot) => Chip(
          label: Text(slot),
        ),
      )
          .toList(),
    );
  }
}
