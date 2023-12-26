import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stadium_reservation/RecurringBooking.dart';
import 'package:stadium_reservation/stadiumSearch.dart';


void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'ENASH',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 20, 
                ),
              ),
              TextSpan(
                text: ' ACTIVE',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 183, 0), 
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black, 
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Image.network(
            'https://images.unsplash.com/photo-1556816214-fda351e4a7fb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your image URL
            height: 350, 
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                    ElevatedButton(
                      onPressed: () {
                                              
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StadiumSearchPage()),
                        );
                        Navigator.pushNamed(context, '/one_time_booking');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 26, horizontal: 40), // Adjust the horizontal padding as needed
                      ),
                      child: const Text(
                        'One-Time Booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecurringBookingPage()),
                        );
                       
                        
                        Navigator.pushNamed(context, '/recurring_booking');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 26, horizontal: 40), // Adjust the horizontal padding as needed
                      ),
                      child: const Text(
                        'Recurring Booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                        ),
                      ),
                    ),
                  ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text('Featured Stadiums', style: TextStyle(fontSize: 18)),
          ),
          Container(
            height: 200,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
              items: [
                
                FeaturedStadiumWidget(imageUrl: 'https://images.unsplash.com/photo-1595030044556-acfaa61edc0f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                FeaturedStadiumWidget(imageUrl: 'https://images.unsplash.com/photo-1533445299615-650a7b20d913?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedStadiumWidget extends StatelessWidget {
  final String imageUrl;

  FeaturedStadiumWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
