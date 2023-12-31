import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enash Active'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to one-time booking page
              Navigator.pushNamed(context, '/one_time_booking');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16), // Adjust padding as needed
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('One-Time Booking'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to recurring booking page
              Navigator.pushNamed(context, '/recurring_booking');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16), // Adjust padding as needed
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Recurring Booking'),
          ),
          SizedBox(height: 16),
          Text('Featured Stadiums', style: TextStyle(fontSize: 18)),
          Container(
            height: 200, // Adjust the height according to your design
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
              items: [
                // Add your featured stadium widgets here
                FeaturedStadiumWidget(imageUrl: 'https://images.unsplash.com/photo-1595030044556-acfaa61edc0f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                FeaturedStadiumWidget(imageUrl: 'https://images.unsplash.com/photo-1533445299615-650a7b20d913?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                // Add more FeaturedStadiumWidget as needed
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
