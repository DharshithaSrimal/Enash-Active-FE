import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StadiumSearchPage(),
      ),
    );

class StadiumSearchPage extends StatefulWidget {
  @override
  _StadiumSearchPageState createState() => _StadiumSearchPageState();
}

class _StadiumSearchPageState extends State<StadiumSearchPage> {
  String? selectedSportType;
  String? selectedDistrict;
  String? selectedCity;
  DateTime selectedDate = DateTime.now();

  TextEditingController _calendarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.black, Colors.grey.shade900, Colors.grey.shade800])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ENASH ACTIVE",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            buildDropdownButton(
                              "Sport Type",
                              sportsTypes,
                              selectedSportType,
                              (String? value) {
                                setState(() {
                                  selectedSportType = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            buildTextFormField("Calendar", _calendarController),
                            SizedBox(height: 10),
                            buildDropdownButton(
                              "District",
                              districts,
                              selectedDistrict,
                              (String? value) {
                                setState(() {
                                  selectedDistrict = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            buildDropdownButton(
                              "City",
                              cities,
                              selectedCity,
                              (String? value) {
                                setState(() {
                                  selectedCity = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildFeaturedStadiumsSlider(),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _showAvailableStadiumsDialog(context);
                        },
                        height: 50,
                        color: Color.fromARGB(255, 1, 157, 223),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Show Available Stadiums",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
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
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
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

  Widget buildTextFormField(String hintText, TextEditingController controller) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onTap: () => _selectDate(context),
        readOnly: true,
      ),
    );
  }

  Widget buildFeaturedStadiumsSlider() {
    List<String> stadiumNames = ['Stadium 1', 'Stadium 2', 'Stadium 3'];

    return CarouselSlider(
      items: [
        'https://images.unsplash.com/photo-1521537634581-0dced2fee2ef?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YmFkbWludG9uJTIwY291cnR8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1611630483685-472d017cbb4f?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1626926938421-90124a4b83fa?q=80&w=1951&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ].map((String imageUrl) {
        String stadiumName = stadiumNames.removeAt(0);

        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _navigateToStadiumPage(stadiumName);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          stadiumName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _calendarController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _showAvailableStadiumsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Available Stadiums"),
          content: Text("Display the list of available stadiums here."),
          actions: [
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

  void _navigateToStadiumPage(String stadiumName) {
    print("Navigate to $stadiumName page");
    // Implement your navigation logic here
  }

  List<String> sportsTypes = ['Badminton', 'Basketball', 'Tennis', 'Indoor Cricket'];
  List<String> districts = ['Colombo', 'Kandy', 'Galle'];
  List<String> cities = ['City A', 'City B', 'City C'];
}
