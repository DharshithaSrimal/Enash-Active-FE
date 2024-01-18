import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stadium_reservation/searchResults.dart';

import 'Stadium.dart';

class StadiumsSearchPage extends StatefulWidget {
  @override
  _StadiumsSearchPageState createState() => _StadiumsSearchPageState();
}

class _StadiumsSearchPageState extends State<StadiumsSearchPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  String? _selectedDistrict;
  String? _selectedCity;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  List<String> districts = ['District A', 'District B', 'District C'];
  List<String> cities = ['City X', 'City Y', 'City Z'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = selectedTime;
          _startTimeController.text = selectedTime.format(context);
        } else {
          _selectedEndTime = selectedTime;
          _endTimeController.text = selectedTime.format(context);
        }
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _searchStadiums() {
    if (_selectedDate == null ||
        _selectedStartTime == null ||
        _selectedEndTime == null ||
        _selectedDistrict == null ||
        _selectedCity == null) {
      _showErrorDialog(context, "All fields must be filled.");
    } else {
      // Perform the search logic
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StadiumResultsPage(searchResults: [
            Stadium(
              name: 'Stadium 1',
              imageUrl:
              'https://images.unsplash.com/photo-1521537634581-0dced2fee2ef?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YmFkbWludG9uJTIwY291cnR8ZW58MHx8MHx8fDA%3D',
              details: 'City X, District A, Date: 2024-01-06, Time: 12:00 PM - 3:00 PM',
            ),
            Stadium(
              name: 'Stadium 2',
              imageUrl:
              'https://images.unsplash.com/photo-1611630483685-472d017cbb4f?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              details: 'City X, District A, Date: 2024-01-06, Time: 2:00 PM - 5:00 PM',
            ),
            Stadium(
              name: 'Stadium 3',
              imageUrl:
              'https://images.unsplash.com/photo-1626926938421-90124a4b83fa?q=80&w=1951&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              details: 'City C, District B, Date: 2024-12-03, Time: 4:00 PM - 7:00 PM',
            ),
          ]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Nearest Badminton Court'),
      ),
      body: Container(
        color: Colors.white10, // Light blue background color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextFormField("Date", _dateController, () => _selectDate(context)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: buildTextFormField("Start Time", _startTimeController, () => _selectTime(context, true)),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: buildTextFormField("End Time", _endTimeController, () => _selectTime(context, false)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildDropdownButton("District", districts, _selectedDistrict, (String? value) {
                setState(() {
                  _selectedDistrict = value;
                });
              }),
              SizedBox(height: 20),
              buildDropdownButton("City", cities, _selectedCity, (String? value) {
                setState(() {
                  _selectedCity = value;
                });
              }),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _searchStadiums,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButton(
      String hintText,
      List<String> items,
      String? value,
      void Function(String?)? onChanged,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        hint: Text(hintText),
        value: value,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget buildTextFormField(String hintText, TextEditingController controller, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(Icons.calendar_today),
          ),
        ),
        onTap: onTap,
        readOnly: true,
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StadiumsSearchPage(),
    ),
  );
}
