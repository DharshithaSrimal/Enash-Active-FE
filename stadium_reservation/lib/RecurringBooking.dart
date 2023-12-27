import 'package:flutter/material.dart';
import 'package:stadium_reservation/Landing.dart';
import 'package:stadium_reservation/searchResults.dart';

class RecurringBookingPage extends StatefulWidget {
  @override
  _RecurringBookingPageState createState() => _RecurringBookingPageState();
}

class _RecurringBookingPageState extends State<RecurringBookingPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _duration = 'Duration';
  String _occurrence = 'Occurrence';
  String _recurringPattern = 'Select Recurring Pattern';

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
          _calculateOccurrence();
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  void _selectRecurringPattern(String pattern) {
    setState(() {
      _recurringPattern = pattern;
    });
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
          _calculateDuration();
        }
      });
    }
  }

  void _calculateDuration() {
    if (_startTime != null && _endTime != null) {
      final startDateTime = DateTime(2023, 1, 1, _startTime!.hour, _startTime!.minute);
      final endDateTime = DateTime(2023, 1, 1, _endTime!.hour, _endTime!.minute);

      final duration = endDateTime.difference(startDateTime);
      _duration = '${duration.inHours} hours ${duration.inMinutes.remainder(60)} minutes';
    } else {
      _duration = 'Select Duration';
    }
  }

  void _calculateOccurrence() {
    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!);
      _occurrence = '${difference.inDays} days';
    } else {
      _occurrence = 'Select Occurrence';
    }
  }

  ElevatedButtonThemeData customButtonStyle({double? width, double? height}) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(width ?? 120, height ?? 50)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Recurring Reservation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Select Appointment Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Start Time:'),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, true),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(50, 50),
                        ),
                        child: Text(_startTime != null ? _startTime!.format(context) : 'Choose Time'),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      const Text('End Time:'),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, false),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(120, 50),
                        ),
                        child: Text(_endTime != null ? _endTime!.format(context) : 'Choose Time'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Duration:'),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(_duration),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              const Text(
                "Recurrence Pattern",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectRecurringPattern('Daily'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(120, 50),
                      ),
                      child: Text('Daily'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectRecurringPattern('Weekly'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(120, 50),
                      ),
                      child: Text('Weekly'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectRecurringPattern('Monthly'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(120, 50),
                      ),
                      child: Text('Monthly'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                "Range of Recurrence",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Start Date:'),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(120, 50),
                        ),
                        child: Text(_startDate != null ? _startDate!.toString().split(' ')[0] : 'Choose Date'),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Text('End Date:'),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(120, 50),
                        ),
                        child: Text(_endDate != null ? _endDate!.toString().split(' ')[0] : 'Choose Date'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                    Navigator.pushNamed(context, '/stadiumResults_page');
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text(
                  'Make Reservation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RecurringBookingPage(),
  ));
}
