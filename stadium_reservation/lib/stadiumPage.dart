import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';

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
  // Replace this URL with your Spring Boot backend endpoint
  final String backendUrl = 'http://localhost:8080/api/stadium';

  // Function to fetch stadium information from the backend
  Future<Map<String, dynamic>?> fetchStadiumInfo() async {
    final response = await http.get(Uri.parse(backendUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stadium information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stadium Information'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchStadiumInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data has been loaded successfully, update your UI accordingly
            return buildStadiumUI(snapshot.data);
          }
        },
      ),
    );
  }

  // Function to build the UI using fetched data
  Widget buildStadiumUI(Map<String, dynamic>? stadiumData) {
    if (stadiumData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  stadiumData['imageURL'] ?? 'https://picsum.photos/seed/picsum/800/200',
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
                      stadiumData['name'] ?? 'Badminton Stadium',
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
                          stadiumData['rating']?.toString() ?? '4.5',
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
                  'Description:\n${stadiumData['description'] ?? 'Lorem ipsum dolor...'}',
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
                buildTimeSlotsList(stadiumData['timeSlots'] ?? []),
                SizedBox(height: 16.0),
                Text(
                  'Location:\n${stadiumData['location'] ?? 'Stadium Address'}',
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
                      'Phone Number: ${stadiumData['phoneNumber'] ?? '+1234567890'}',
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
    );
  }

  Widget buildTimeSlotsList(List<String> timeSlots) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: timeSlots.map((slot) => Chip(label: Text(slot))).toList(),
    );
  }
}
