import 'package:flutter/material.dart';
import 'package:stadium_reservation/stadiumPage.dart';

class Stadium {
  final String name;
  final String imageUrl;
  final String details;

  Stadium({
    required this.name,
    required this.imageUrl,
    required this.details,
  });
}

class StadiumResultsPage extends StatelessWidget {
  final List<Stadium> searchResults;

  const StadiumResultsPage({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stadium Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Stadium stadium = searchResults[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(25.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  onTap: () {
                    _navigateToStadiumInfoPage(context, stadium);
                  },
                  child: Image.network(
                    stadium.imageUrl,
                    width: 250.0,
                    height: 240.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  _navigateToStadiumInfoPage(context, stadium);
                },
                child: Text(
                  stadium.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(
                stadium.details,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                _navigateToStadiumInfoPage(context, stadium);
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToStadiumDetailPage(BuildContext context, Stadium stadium) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StadiumInfoPage(),
      ),
    );
  }

  void _navigateToStadiumInfoPage(BuildContext context, Stadium stadium) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StadiumInfoPage(),
      ),
    );
  }
}



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StadiumResultsPage(
        searchResults: [
          Stadium(
            name: 'Stadium 1',
            imageUrl:
                'https://images.unsplash.com/photo-1521537634581-0dced2fee2ef?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YmFkbWludG9uJTIwY291cnR8ZW58MHx8MHx8fDA%3D',
            details: 'City A, District X',
          ),
          Stadium(
            name: 'Stadium 2',
            imageUrl:
                'https://images.unsplash.com/photo-1611630483685-472d017cbb4f?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            details: 'City B, District Y',
          ),
          Stadium(
            name: 'Stadium 3',
            imageUrl:
                'https://images.unsplash.com/photo-1626926938421-90124a4b83fa?q=80&w=1951&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            details: 'City C, District Z',
          ),
        ],
      ),
    ),
  );
}