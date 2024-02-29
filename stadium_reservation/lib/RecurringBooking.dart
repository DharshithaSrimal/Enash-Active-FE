import 'package:flutter/material.dart';
import 'package:stadium_reservation/Landing.dart';

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
  Set<String> _selectedDays = Set<String>();

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
      if (_recurringPattern == 'Weekly') {
        _showDaysDialog();
      } else if (_recurringPattern == 'Daily') {
        _showDaysDialog();
      } else if (_recurringPattern == 'Monthly') {
        _showMonthlyDialog();
      }
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

  void _showDaysDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Days'),
          content: Column(
            children: _buildDayButtons(),
          ),
        );
      },
    );
  }

  void _showMonthlyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Monthly Recurrence'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Day'),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter day',
                  ),
                ),
                SizedBox(height: 16),
                Text('of every'),
                SizedBox(height: 8),
                DropdownButton<String>(
                  value: 'First', // Set default value or initialize it based on your logic
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  items: <String>['First', 'Last'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
            
            
                SizedBox(height: 16),
                DropdownButton<String>(
                  value: 'Monday', // Set default value or initialize it based on your logic
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            
                ),
                SizedBox(height: 16),
                Text('of every Month'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(120, 50),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildDayButtons() {
    if (_recurringPattern == 'Weekly') {
      return [
        _buildDayButton('Monday'),
        SizedBox(height: 8),
        _buildDayButton('Tuesday'),
        SizedBox(height: 8),
        _buildDayButton('Wednesday'),
        SizedBox(height: 8),
        _buildDayButton('Thursday'),
        SizedBox(height: 8),
        _buildDayButton('Friday'),
        SizedBox(height: 8),
        _buildDayButton('Saturday'),
        SizedBox(height: 8),
        _buildDayButton('Sunday'),
        SizedBox(height: 8),
        _buildConfirmButton(),
      ];
    } else if (_recurringPattern == 'Daily') {
      return [
        _buildDailyButton('Every'),
        SizedBox(height: 8),
        _buildDailyButton('Every Weekday'),
        SizedBox(height: 8),
        _buildDailyButton('Every Weekend'),
        SizedBox(height: 8),
        _buildConfirmButton(),
      ];
    } else {
      // Add conditions for other recurring patterns if needed
      return [];
    }
  }

  Widget _buildDayButton(String day) {
    final isSelected = _selectedDays.contains(day);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            _selectedDays.remove(day);
          } else {
            _selectedDays.add(day);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(120, 50),
      ),
      child: Text(day),
    );
  }

  Widget _buildDailyButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle the daily options as needed
        print('Selected $label');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(120, 50),
      ),
      child: Text(label),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(); // Close the dialog
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Set white color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(120, 50),
      ),
      child: Text(
        'Confirm',
        style: TextStyle(
          color: Colors.blue, // Set blue color for the text
          fontWeight: FontWeight.bold, // Make the text bold
        ),
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
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Start Time:'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(_startTime != null ? _startTime!.format(context) : 'Choose Time'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End Time:'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(_endTime != null ? _endTime!.format(context) : 'Choose Time'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration:'),
                  SizedBox(height: 8),
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
                        backgroundColor: Colors.white,
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
                        backgroundColor: Colors.white,
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
                        backgroundColor: Colors.white,
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
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Start Date:'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(_startDate != null ? _startDate!.toString().split(' ')[0] : 'Choose Date'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End Date:'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(_endDate != null ? _endDate!.toString().split(' ')[0] : 'Choose Date'),
                        ),
                      ],
                    ),
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
                  backgroundColor: Colors.blue,
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

