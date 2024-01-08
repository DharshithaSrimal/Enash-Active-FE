import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:stadium_reservation/ConfirmBooking.dart';
import 'package:http/http.dart' as http;

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
      home: StadiumInfoPage(
        selectedDate: DateTime
            .now(), // Replace with the selected date from the search page
        selectedTime:
            'Monday: 10:00 AM - 12:00 PM', // Replace with the selected time from the search page
      ),
    );
  }
}

class StadiumInfoPage extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;

  // Use constructor initializer list for non-constant default values
  StadiumInfoPage({DateTime? selectedDate, String? selectedTime})
      : selectedDate = selectedDate ?? DateTime(2023, 1, 1),
        selectedTime = selectedTime ?? 'Monday: 10:00 AM - 12:00 PM';

  @override
  _StadiumInfoPageState createState() => _StadiumInfoPageState();
}

class _StadiumInfoPageState extends State<StadiumInfoPage> {
  List<bool> _selections = [false, false];
  List<bool> _courtSelections = [false, false, false, false];

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
                  const Text(
                    'Available Courts:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  buildCourtsList(['Court A', 'Court B', 'Court C', 'Court D']),
                  SizedBox(height: 16.0),
                  Text(
                    'Location:\nYour Stadium Address',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Date and Time Fields
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'Date: ${widget.selectedDate.toLocal()}'.split(' ')[0],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'Time: ${widget.selectedTime}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  const Row(
                    children: [
                      Text(
                        'Hourly Rate: ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Reserve Button
            const SizedBox(height: 16.0),

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

  Widget buildCourtsList(List<String> courts) {
    return Wrap(
      spacing: 16.0, // Adjust spacing between courts
      runSpacing: 16.0, // Adjust spacing between rows of courts
      children: courts
          .asMap()
          .entries
          .map(
            (entry) => GestureDetector(
              onTap: () {
                setState(() {
                  _courtSelections[entry.key] = !_courtSelections[entry.key];
                });
              },
              child: Chip(
                label: Text(entry.value),
                backgroundColor: _courtSelections[entry.key]
                    ? const Color.fromARGB(255, 143, 219, 255)
                    : null,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Adjust padding
              ),
            ),
          )
          .toList(),
    );
  }

  void _navigateToConfirmBookingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmBookingPage(
          courtName: 'Badminton Stadium',
          timeSlot: widget.selectedTime,
          courtNo: _getSelectedCourts(),
          price: 'LKR 800.00',
        ),
      ),
    );
  }

  String _getSelectedCourts() {
    List<String> selectedCourts = [];
    for (int i = 0; i < _courtSelections.length; i++) {
      if (_courtSelections[i]) {
        selectedCourts.add('Court ${String.fromCharCode(65 + i)}');
      }
    }
    return selectedCourts.join(', ');
  }

  void fetchStadiums() {
    const stadiumEndpoint = ''; // API Endpoint
    final uri = Uri.parse(uri);
    final stadiumResponse = await http.get(uri);
    final body = stadiumResponse.body;
    final json = jsonDecode(body);
    //handle the json to get the results
    // setState((){
    //   stadiums = json['results'];
    // });
  }
}
