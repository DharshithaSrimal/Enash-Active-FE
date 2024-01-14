import 'package:flutter/material.dart';
import 'package:stadium_reservation/ConfirmBooking.dart';

import 'PaymentPage.dart';


class StadiumInfoPage extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;


  var imageUrl;

  var name;

  // Use constructor initializer list for non-constant default values
  StadiumInfoPage({
    Key? key,
    DateTime? selectedDate,
    String? selectedTime,
    required this.imageUrl, // Add this
    required this.name, // Add this
  })  : selectedDate = selectedDate ?? DateTime(2023, 1, 1),
        selectedTime = selectedTime ?? 'Monday: 10:00 AM - 12:00 PM',
        super(key: key);

  @override
  _StadiumInfoPageState createState() => _StadiumInfoPageState();
}

class _StadiumInfoPageState extends State<StadiumInfoPage> {
  List<bool> _selections = [false, false];
  List<bool> _courtSelections = [false, false, false, false];
  var courtName = [];


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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
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
                    ),
                    Divider(),
                    SizedBox(height: 8.0),
                    Text(
                      'Description:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Available Courts:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    buildCourtsList(['Court A', 'Court B', 'Court C', 'Court D']),
                    SizedBox(height: 16.0),
                    Divider(),
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
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Divider(),
                    Text('Hourly Rate: ',style: TextStyle(
                      fontSize: 16.0,
                    ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Reserve Button
            FloatingActionButton.extended(
              onPressed: () {
                // Navigate to ConfirmBookingPage when Reserve button is pressed
                _navigateToConfirmBookingPage(context);
              },
              icon: Icon(Icons.calendar_today), // Your icon here
              label: Text('Reserve'),
              backgroundColor: Colors.deepOrange,
            ),          ],
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


                courtName.add(entry.value);
              },
              child: Chip(
                label: Text(entry.value),
                backgroundColor: _courtSelections[entry.key] ? const Color.fromARGB(255, 143, 219, 255) : null,
                labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjust padding
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
        builder: (context) => PaymentPage(
          stadiumName: 'Badminton Stadium', // Pass relevant data to PaymentPage
          location: 'Your Stadium Address', // Pass relevant data to PaymentPage
          timeSlot: widget.selectedTime, // Pass relevant data to PaymentPage
          price: 800.0, court: courtName, // Pass relevant data to PaymentPage
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
}
